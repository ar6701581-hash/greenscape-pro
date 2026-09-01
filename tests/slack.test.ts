/**
 * tests/slack.test.ts
 *
 * Unit tests for src/lib/slack/notify.ts
 *
 * These tests cover:
 *   1. Unconfigured webhook → soft-success (no crash)
 *   2. Successful dispatch → { success: true }
 *   3. Non-200 HTTP response → { success: false, error: <message> }
 *   4. Network timeout (AbortError) → { success: false, error: "timed out" message }
 *   5. CRITICAL: Slack failure never causes APPROVED → FAILED (state machine invariant)
 *
 * All tests use `vi.stubGlobal` to mock `fetch` so no real HTTP calls are made.
 */

import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { sendSlackApprovalNotification } from '../src/lib/slack/notify';
import { validateStateTransition } from '../src/lib/proposals/state-machine';

// ---------------------------------------------------------------------------
// Shared payload used across tests
// ---------------------------------------------------------------------------
const TEST_PAYLOAD = {
  proposalId: 'proposal-uuid-1234',
  customerName: 'Jane Smith',
  address: '742 Evergreen Terrace, Phoenix, AZ',
  totalAmount: 35500,
  renderRequired: true,
};

// ---------------------------------------------------------------------------
// Helper: build a minimal Response-like object for fetch mocking
// ---------------------------------------------------------------------------
function mockResponse(status: number, body: string): Response {
  return {
    ok: status >= 200 && status < 300,
    status,
    text: async () => body,
  } as unknown as Response;
}

beforeEach(() => {
  vi.restoreAllMocks();
});

afterEach(() => {
  delete process.env.SLACK_WEBHOOK_URL;
});

// ---------------------------------------------------------------------------
// 1. Unconfigured webhook
// ---------------------------------------------------------------------------
describe('sendSlackApprovalNotification — unconfigured webhook', () => {
  it('returns { success: true } and skips fetch when SLACK_WEBHOOK_URL is not set', async () => {
    delete process.env.SLACK_WEBHOOK_URL;
    const fetchSpy = vi.spyOn(globalThis, 'fetch');

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(true);
    expect(result.error).toBeUndefined();
    expect(fetchSpy).not.toHaveBeenCalled();
  });

  it('returns { success: true } when SLACK_WEBHOOK_URL contains placeholder sentinel', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/your/webhook/url';
    const fetchSpy = vi.spyOn(globalThis, 'fetch');

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(true);
    expect(fetchSpy).not.toHaveBeenCalled();
  });
});

// ---------------------------------------------------------------------------
// 2. Successful dispatch
// ---------------------------------------------------------------------------
describe('sendSlackApprovalNotification — successful dispatch', () => {
  it('returns { success: true } on 200 OK from Slack webhook', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(mockResponse(200, 'ok')));

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(true);
    expect(result.error).toBeUndefined();
  });

  it('POSTs JSON body to the configured webhook URL', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    const fetchMock = vi.fn().mockResolvedValue(mockResponse(200, 'ok'));
    vi.stubGlobal('fetch', fetchMock);

    await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(fetchMock).toHaveBeenCalledOnce();
    const [url, options] = fetchMock.mock.calls[0] as [string, RequestInit];
    expect(url).toBe('https://hooks.slack.com/services/T000/B000/real_token');
    expect(options.method).toBe('POST');
    expect(options.headers).toMatchObject({ 'Content-Type': 'application/json' });

    // Body must be valid JSON containing the proposal ID
    const body = JSON.parse(options.body as string);
    expect(JSON.stringify(body)).toContain(TEST_PAYLOAD.proposalId);
  });

  it('message body contains customerName, totalAmount formatted as USD, and renderRequired flag', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    const fetchMock = vi.fn().mockResolvedValue(mockResponse(200, 'ok'));
    vi.stubGlobal('fetch', fetchMock);

    await sendSlackApprovalNotification(TEST_PAYLOAD);

    const [, options] = fetchMock.mock.calls[0] as [string, RequestInit];
    const bodyStr = options.body as string;

    expect(bodyStr).toContain('Jane Smith');
    expect(bodyStr).toContain('$35,500.00');
    // render required flag message
    expect(bodyStr).toContain('CARLOS RENDER REQUIRED');
  });

  it('message body includes proposal URL with the correct proposalId', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';
    process.env.NEXT_PUBLIC_APP_URL = 'https://greenscape.example.com';

    const fetchMock = vi.fn().mockResolvedValue(mockResponse(200, 'ok'));
    vi.stubGlobal('fetch', fetchMock);

    await sendSlackApprovalNotification(TEST_PAYLOAD);

    const [, options] = fetchMock.mock.calls[0] as [string, RequestInit];
    const bodyStr = options.body as string;

    expect(bodyStr).toContain(`https://greenscape.example.com/proposals/${TEST_PAYLOAD.proposalId}`);

    delete process.env.NEXT_PUBLIC_APP_URL;
  });
});

// ---------------------------------------------------------------------------
// 3. HTTP error responses
// ---------------------------------------------------------------------------
describe('sendSlackApprovalNotification — HTTP error responses', () => {
  it('returns { success: false, error } on non-200 Slack response', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(mockResponse(400, 'invalid_payload')));

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(false);
    expect(result.error).toBeDefined();
    expect(result.error).toContain('400');
  });

  it('returns { success: false, error } on 5xx from Slack', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(mockResponse(500, 'server_error')));

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(false);
    expect(result.error).toContain('500');
  });
});

// ---------------------------------------------------------------------------
// 4. Network / timeout errors
// ---------------------------------------------------------------------------
describe('sendSlackApprovalNotification — network failures', () => {
  it('returns { success: false, error } when fetch rejects (network error)', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    vi.stubGlobal(
      'fetch',
      vi.fn().mockRejectedValue(new Error('Failed to fetch'))
    );

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(false);
    expect(result.error).toContain('Failed to fetch');
  });

  it('returns { success: false, error } with timeout message on AbortError', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    const abortError = new Error('The operation was aborted');
    abortError.name = 'AbortError';

    vi.stubGlobal('fetch', vi.fn().mockRejectedValue(abortError));

    const result = await sendSlackApprovalNotification(TEST_PAYLOAD);

    expect(result.success).toBe(false);
    expect(result.error).toContain('timed out');
  });
});

// ---------------------------------------------------------------------------
// 5. CRITICAL INVARIANT: Slack failure must never cause APPROVED → FAILED
// ---------------------------------------------------------------------------
describe('CRITICAL: Slack failure non-blocking invariant', () => {
  it('state machine forbids APPROVED → FAILED transition regardless of Slack outcome', () => {
    // This mirrors the guarantee enforced in approve/route.ts:
    // even when slackResult.success === false, the proposal stays APPROVED.
    expect(validateStateTransition('APPROVED', 'FAILED')).toBe(false);
  });

  it('Slack failure result does NOT itself throw, ensuring outer try/catch cannot catch and FAIL proposal', async () => {
    process.env.SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/T000/B000/real_token';

    vi.stubGlobal('fetch', vi.fn().mockRejectedValue(new Error('connection refused')));

    // Must resolve (not throw) — a thrown error here would bubble up and could set status=FAILED
    await expect(sendSlackApprovalNotification(TEST_PAYLOAD)).resolves.toMatchObject({
      success: false,
      error: expect.any(String),
    });
  });
});
