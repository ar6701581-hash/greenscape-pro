import React from 'react';

interface AuditEvent {
  id: string;
  action: string;
  actor: string;
  previous_status?: string | null;
  new_status?: string | null;
  notes?: string | null;
  created_at: string;
}

export function AuditTimeline({ events }: { events: AuditEvent[] }) {
  if (!events || events.length === 0) return null;

  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 space-y-4">
      <h3 className="font-bold text-gray-900 text-base flex items-center gap-2">
        <span>📜</span> Audit Trail & History
      </h3>
      <div className="relative pl-6 border-l-2 border-emerald-200 space-y-6">
        {events.map(ev => (
          <div key={ev.id} className="relative group">
            <div className="absolute -left-[31px] top-1 w-4 h-4 rounded-full bg-emerald-500 border-4 border-white shadow-sm" />
            <div className="flex items-center justify-between">
              <span className="text-xs font-bold text-gray-900 uppercase tracking-wide">
                {ev.action}
              </span>
              <span className="text-[11px] text-gray-400">
                {new Date(ev.created_at).toLocaleString()}
              </span>
            </div>
            <div className="text-xs text-gray-600 mt-0.5">
              By <span className="font-semibold text-gray-800">{ev.actor}</span>
              {ev.previous_status && ev.new_status && (
                <span className="ml-1.5 font-mono text-[11px] bg-gray-100 px-1.5 py-0.5 rounded">
                  {ev.previous_status} → {ev.new_status}
                </span>
              )}
            </div>
            {ev.notes && <p className="text-xs text-gray-500 mt-1 italic">{ev.notes}</p>}
          </div>
        ))}
      </div>
    </div>
  );
}
