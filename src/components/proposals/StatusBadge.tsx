import React from 'react';

export function StatusBadge({ status }: { status: string }) {
  const styles: Record<string, string> = {
    DRAFT: 'bg-gray-100 text-gray-800 border-gray-300',
    NEEDS_CLARIFICATION: 'bg-amber-100 text-amber-900 border-amber-300 animate-pulse',
    NEEDS_REVIEW: 'bg-blue-100 text-blue-900 border-blue-300',
    APPROVED: 'bg-emerald-100 text-emerald-900 border-emerald-300',
    SENT: 'bg-teal-100 text-teal-900 border-teal-300',
    FAILED: 'bg-rose-100 text-rose-900 border-rose-300'
  };

  const labels: Record<string, string> = {
    DRAFT: 'Drafting Scope',
    NEEDS_CLARIFICATION: 'Needs Clarification',
    NEEDS_REVIEW: 'Ready for Review',
    APPROVED: 'Approved',
    SENT: 'Sent to Customer',
    FAILED: 'Processing Error'
  };

  const style = styles[status] || 'bg-gray-100 text-gray-800 border-gray-300';
  const label = labels[status] || status;

  return (
    <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold border ${style}`}>
      {label}
    </span>
  );
}

export function RenderRequiredFlag({ required, note }: { required: boolean; note?: string | null }) {
  if (!required) return null;

  return (
    <div className="bg-rose-600 text-white font-bold text-sm px-4 py-3 rounded-lg shadow-md flex items-center justify-between border-2 border-rose-700">
      <div className="flex items-center space-x-2">
        <span className="text-xl">⚠️</span>
        <div>
          <div className="uppercase tracking-wider">Carlos Render Required</div>
          <div className="text-xs font-normal text-rose-100">{note || 'Calculated proposal total exceeds $30,000 threshold. Flagged for review.'}</div>
        </div>
      </div>
      <span className="text-xs bg-rose-800 px-2.5 py-1 rounded uppercase tracking-wide">Internal Flag</span>
    </div>
  );
}
