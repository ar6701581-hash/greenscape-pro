'use client';

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { StatusBadge, RenderRequiredFlag } from '@/components/proposals/StatusBadge';
import { LineItemEditor } from '@/components/proposals/LineItemEditor';
import { ClarificationPanel } from '@/components/proposals/ClarificationPanel';
import { AuditTimeline } from '@/components/proposals/AuditTimeline';

export default function ProposalDetailPage({ params }: { params: { id: string } }) {
  const proposalId = params.id;

  const [proposal, setProposal] = useState<any>(null);
  const [lineItems, setLineItems] = useState<any[]>([]);
  const [clarifications, setClarifications] = useState<any[]>([]);
  const [auditEvents, setAuditEvents] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [approving, setApproving] = useState(false);
  const [actionMsg, setActionMsg] = useState<{ type: 'success' | 'warning' | 'error'; text: string } | null>(null);

  const fetchProposalData = async () => {
    try {
      const res = await fetch(`/api/proposals/${proposalId}`);
      if (!res.ok) throw new Error('Proposal not found');
      const data = await res.json();

      setProposal(data.proposal);
      setLineItems(data.lineItems || []);
      setClarifications(data.clarifications || []);
      setAuditEvents(data.auditEvents || []);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchProposalData();
  }, [proposalId]);

  const handleApprove = async () => {
    if (!proposal) return;
    setActionMsg(null);
    setApproving(true);

    try {
      const res = await fetch(`/api/proposals/${proposalId}/approve`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ expectedVersion: proposal.version })
      });

      const data = await res.json();

      if (!res.ok) {
        setActionMsg({ type: 'error', text: data.error || 'Failed to approve proposal' });
      } else {
        if (data.warning) {
          setActionMsg({ type: 'warning', text: data.warning });
        } else {
          setActionMsg({ type: 'success', text: data.message || 'Proposal approved and SENT!' });
        }
        fetchProposalData();
      }
    } catch (err) {
      setActionMsg({ type: 'error', text: (err as Error).message });
    } finally {
      setApproving(false);
    }
  };

  if (loading) {
    return <div className="p-12 text-center text-gray-400 text-sm">Loading proposal details...</div>;
  }

  if (!proposal) {
    return <div className="p-12 text-center text-rose-600 font-bold">Proposal not found.</div>;
  }

  const isApprovedOrSent = proposal.status === 'APPROVED' || proposal.status === 'SENT';
  const unresolvedClarificationCount = clarifications.filter(c => !c.resolved).length;
  const canApprove = proposal.status === 'NEEDS_REVIEW' && unresolvedClarificationCount === 0;

  return (
    <div className="max-w-6xl mx-auto p-6 space-y-6">
      {/* Top Navigation */}
      <div className="flex items-center justify-between">
        <Link href="/" className="text-xs font-semibold text-emerald-700 hover:underline">
          ← Back to Dashboard
        </Link>
        <div className="text-xs text-gray-400 font-mono">ID: {proposal.id}</div>
      </div>

      {/* Action Notifications */}
      {actionMsg && (
        <div
          className={`p-4 rounded-xl text-sm font-semibold border ${
            actionMsg.type === 'error'
              ? 'bg-rose-50 text-rose-800 border-rose-200'
              : actionMsg.type === 'warning'
              ? 'bg-amber-50 text-amber-800 border-amber-200'
              : 'bg-emerald-50 text-emerald-800 border-emerald-200'
          }`}
        >
          {actionMsg.text}
        </div>
      )}

      {/* Render Required Prominent Flag */}
      <RenderRequiredFlag required={proposal.render_required} note={proposal.render_flag_note} />

      {/* Proposal Header Banner */}
      <div className="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm flex flex-col md:flex-row md:items-center md:justify-between gap-6">
        <div>
          <div className="flex items-center gap-3">
            <h1 className="text-2xl font-black text-gray-900">{proposal.leads?.name || 'Customer Lead'}</h1>
            <StatusBadge status={proposal.status} />
          </div>
          <p className="text-xs text-gray-500 mt-1">
            {proposal.leads?.address || 'Phoenix, AZ'} | Conducted by Marcus Tate
          </p>
        </div>

        {/* Total & Server Approval Button */}
        <div className="flex items-center gap-6">
          <div className="text-right">
            <div className="text-xs text-gray-500 font-semibold uppercase tracking-wider">Calculated Total</div>
            <div className="text-3xl font-black text-emerald-700">
              ${(proposal.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2 })}
            </div>
            {proposal.tax_amount > 0 && (
              <div className="text-[11px] text-gray-400">Includes ${(proposal.tax_amount).toFixed(2)} tax</div>
            )}
          </div>

          {!isApprovedOrSent && (
            <button
              onClick={handleApprove}
              disabled={!canApprove || approving}
              className="px-6 py-3 bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-sm rounded-xl shadow-lg hover:shadow-emerald-200 disabled:opacity-50 transition flex items-center space-x-2"
            >
              {approving ? (
                <span>Approving & Notifying...</span>
              ) : (
                <span>Approve Proposal ✓</span>
              )}
            </button>
          )}
        </div>
      </div>

      {/* AI Project Summary */}
      {proposal.project_summary && (
        <div className="bg-emerald-50/50 p-5 rounded-xl border border-emerald-100 space-y-1">
          <h3 className="text-xs font-bold text-emerald-900 uppercase tracking-wider">AI Scope Summary</h3>
          <p className="text-sm text-emerald-950 font-medium">{proposal.project_summary}</p>
        </div>
      )}

      {/* Site Walk Raw Notes (Collapsible View) */}
      <details className="bg-white p-4 rounded-xl border border-gray-200 shadow-sm text-sm">
        <summary className="font-bold text-gray-800 cursor-pointer select-none flex justify-between items-center">
          <span>View Marcus's Original Raw Site-Walk Notes</span>
          <span className="text-xs text-gray-400 font-normal">Click to expand</span>
        </summary>
        <div className="mt-3 p-3 bg-gray-50 rounded-lg text-xs font-mono text-gray-700 whitespace-pre-wrap border border-gray-100">
          {proposal.site_walks?.raw_notes}
        </div>
      </details>

      {/* Clarification Panel (if pending) */}
      <ClarificationPanel
        proposalId={proposal.id}
        clarifications={clarifications}
        isReadOnly={isApprovedOrSent}
        onRefresh={fetchProposalData}
      />

      {/* Line Item Scope & Pricing Table */}
      <LineItemEditor
        proposalId={proposal.id}
        lineItems={lineItems}
        isReadOnly={isApprovedOrSent}
        onRefresh={fetchProposalData}
      />

      {/* Audit History Timeline */}
      <AuditTimeline events={auditEvents} />
    </div>
  );
}
