export type ProposalStatus =
  | 'DRAFT'
  | 'NEEDS_CLARIFICATION'
  | 'NEEDS_REVIEW'
  | 'APPROVED'
  | 'SENT'
  | 'FAILED';

export class InvalidTransitionError extends Error {
  constructor(public from: ProposalStatus, public to: ProposalStatus) {
    super(`Invalid proposal state transition from "${from}" to "${to}".`);
    this.name = 'InvalidTransitionError';
  }
}

const VALID_TRANSITIONS: Record<ProposalStatus, ProposalStatus[]> = {
  DRAFT: ['NEEDS_CLARIFICATION', 'NEEDS_REVIEW', 'FAILED'],
  NEEDS_CLARIFICATION: ['NEEDS_REVIEW', 'FAILED'],
  NEEDS_REVIEW: ['APPROVED', 'DRAFT', 'FAILED'],
  APPROVED: ['SENT'], // CRITICAL: Slack failure leaves proposal in APPROVED (never FAILED)
  SENT: [],
  FAILED: []
};

export function validateStateTransition(from: ProposalStatus, to: ProposalStatus): boolean {
  return VALID_TRANSITIONS[from]?.includes(to) ?? false;
}

export function assertValidTransition(from: ProposalStatus, to: ProposalStatus): void {
  if (!validateStateTransition(from, to)) {
    throw new InvalidTransitionError(from, to);
  }
}
