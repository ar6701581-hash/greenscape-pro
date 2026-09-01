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

export function RenderRequiredFlag({
  required,
  note,
  unresolvedCount = 0
}: {
  required: boolean;
  note?: string | null;
  unresolvedCount?: number;
}) {
  if (!required) return null;

  const renderReady = unresolvedCount === 0;

  return (
    <div className="bg-rose-900/90 text-white font-medium text-sm px-5 py-3.5 rounded-xl shadow-md flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 border-2 border-rose-700">
      <div className="flex items-center space-x-3">
        <span className="text-2xl">⚠️</span>
        <div>
          <div className="font-extrabold uppercase tracking-wider text-rose-100 flex items-center gap-2">
            <span>Render Required: Yes</span>
            <span className="text-xs bg-rose-800 px-2 py-0.5 rounded text-rose-200">($30k+ Threshold)</span>
          </div>
          <div className="text-xs text-rose-200 mt-0.5">
            {note || 'Calculated proposal total reaches or exceeds $30,000 threshold.'}
          </div>
        </div>
      </div>
      <div className="flex items-center gap-2 font-bold text-xs bg-rose-950/80 px-3 py-2 rounded-lg border border-rose-800/60 self-start sm:self-auto">
        <span>Render Ready:</span>
        {renderReady ? (
          <span className="text-emerald-400 bg-emerald-950/80 px-2 py-0.5 rounded border border-emerald-700">
            Yes ✓
          </span>
        ) : (
          <span className="text-amber-300 bg-amber-950/80 px-2 py-0.5 rounded border border-amber-700">
            No — {unresolvedCount} scope clarification{unresolvedCount > 1 ? 's' : ''} remain
          </span>
        )}
      </div>
    </div>
  );
}
