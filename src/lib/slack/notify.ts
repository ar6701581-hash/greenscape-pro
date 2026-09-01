export interface SlackNotificationPayload {
  proposalId: string;
  customerName: string;
  address: string;
  totalAmount: number;
  renderRequired: boolean;
}

export async function sendSlackApprovalNotification(
  payload: SlackNotificationPayload
): Promise<{ success: boolean; error?: string }> {
  const webhookUrl = process.env.SLACK_WEBHOOK_URL;
  const baseUrl = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000';

  if (!webhookUrl || webhookUrl.includes('your/webhook/url')) {
    console.warn('⚠️ SLACK_WEBHOOK_URL is not configured. Skipping external Slack notification.');
    return { success: true }; // Treat as soft-success when webhook isn't configured in demo
  }

  const renderBadge = payload.renderRequired
    ? '⚠️ *YES — CARLOS RENDER REQUIRED*'
    : 'No (Standard Proposal)';

  const formattedTotal = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD'
  }).format(payload.totalAmount);

  const messageBlock = {
    text: `🌿 New Proposal Approved — Greenscape Pro`,
    blocks: [
      {
        type: 'header',
        text: {
          type: 'plain_text',
          text: '🌿 New Proposal Approved — Greenscape Pro',
          emoji: true
        }
      },
      {
        type: 'section',
        fields: [
          {
            type: 'mrkdwn',
            text: `*Customer:*\n${payload.customerName}`
          },
          {
            type: 'mrkdwn',
            text: `*Project Total:*\n\`${formattedTotal}\``
          },
          {
            type: 'mrkdwn',
            text: `*Location:*\n${payload.address}`
          },
          {
            type: 'mrkdwn',
            text: `*3D Render Flag:*\n${renderBadge}`
          }
        ]
      },
      {
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*Proposal ID:* \`${payload.proposalId}\``
        }
      },
      {
        type: 'actions',
        elements: [
          {
            type: 'button',
            text: {
              type: 'plain_text',
              text: 'View Approved Proposal →',
              emoji: true
            },
            url: `${baseUrl}/proposals/${payload.proposalId}`,
            style: 'primary'
          }
        ]
      }
    ]
  };

  try {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 10000); // 10s fail-safe timeout

    const response = await fetch(webhookUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(messageBlock),
      signal: controller.signal
    });

    clearTimeout(timeoutId);

    if (!response.ok) {
      const errText = await response.text();
      throw new Error(`Slack API responded with status ${response.status}: ${errText}`);
    }

    return { success: true };
  } catch (err) {
    const errorMsg = (err as Error).name === 'AbortError'
      ? 'Slack webhook request timed out after 10 seconds.'
      : (err as Error).message;

    console.error('❌ Failed to dispatch Slack webhook notification:', errorMsg);
    return { success: false, error: errorMsg };
  }
}
