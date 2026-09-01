'use client';

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { StatusBadge } from '@/components/proposals/StatusBadge';

interface ProposalSummary {
  id: string;
  status: string;
  total_amount: number;
  subtotal: number;
  render_required: boolean;
  render_flag_note?: string;
  created_at: string;
  leads?: {
    name: string;
    address: string;
    city: string;
  };
}

export default function DashboardPage() {
  const [proposals, setProposals] = useState<ProposalSummary[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/dashboard', { cache: 'no-store' })
      .then(res => res.json())
      .then(data => setProposals(data.proposals || []))
      .catch(err => console.error(err))
      .finally(() => setLoading(false));
  }, []);

  const counts = proposals.reduce((acc, p) => {
    acc[p.status] = (acc[p.status] || 0) + 1;
    return acc;
  }, {} as Record<string, number>);

  return (
    <div className="max-w-7xl mx-auto p-6 space-y-8">
      {/* Header Banner */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 bg-white p-6 rounded-2xl border border-emerald-100 shadow-sm">
        <div>
          <h1 className="text-2xl font-black text-gray-900 tracking-tight">Greenscape Pro</h1>
          <p className="text-xs text-gray-500 mt-1">AI Proposal & Quote Drafting Agent Operations Dashboard</p>
        </div>
        <Link
          href="/proposals/new"
          className="inline-flex items-center justify-center px-5 py-2.5 bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-sm rounded-xl shadow-lg hover:shadow-emerald-200 transition"
        >
          + Create New Proposal
        </Link>
      </div>

      {/* Metric Cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
        <div className="bg-white p-5 rounded-xl border border-gray-100 shadow-sm">
          <div className="text-xs text-gray-500 font-semibold">Total Proposals</div>
          <div className="text-2xl font-black text-gray-900 mt-1">{proposals.length}</div>
        </div>
        <div className="bg-white p-5 rounded-xl border border-amber-100 shadow-sm">
          <div className="text-xs text-amber-800 font-semibold">Needs Clarification</div>
          <div className="text-2xl font-black text-amber-700 mt-1">{counts['NEEDS_CLARIFICATION'] || 0}</div>
        </div>
        <div className="bg-white p-5 rounded-xl border border-blue-100 shadow-sm">
          <div className="text-xs text-blue-800 font-semibold">Ready for Review</div>
          <div className="text-2xl font-black text-blue-700 mt-1">{counts['NEEDS_REVIEW'] || 0}</div>
        </div>
        <div className="bg-white p-5 rounded-xl border border-emerald-100 shadow-sm">
          <div className="text-xs text-emerald-800 font-semibold">Approved / Sent</div>
          <div className="text-2xl font-black text-emerald-700 mt-1">
            {(counts['APPROVED'] || 0) + (counts['SENT'] || 0)}
          </div>
        </div>
      </div>

      {/* Recent Proposals Table */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
          <h2 className="font-bold text-gray-900 text-base">Recent Proposals</h2>
          <span className="text-xs text-gray-400">Sorted by creation date</span>
        </div>

        {loading ? (
          <div className="p-12 text-center text-gray-400 text-sm">Loading operations pipeline...</div>
        ) : proposals.length === 0 ? (
          <div className="p-12 text-center text-gray-400 text-sm">
            No proposals generated yet. Click <span className="font-semibold text-emerald-700">&quot;Create New Proposal&quot;</span> to process your first site-walk notes.
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm text-gray-700">
              <thead className="bg-gray-50 text-xs font-bold text-gray-600 uppercase border-b">
                <tr>
                  <th className="px-6 py-3">Lead / Customer</th>
                  <th className="px-4 py-3">Status</th>
                  <th className="px-4 py-3 text-right">Calculated Total</th>
                  <th className="px-4 py-3 text-center">Render Flag</th>
                  <th className="px-4 py-3">Created</th>
                  <th className="px-6 py-3 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {proposals.map(p => (
                  <tr key={p.id} className="hover:bg-gray-50/50 transition">
                    <td className="px-6 py-4">
                      <div className="font-bold text-gray-900">{p.leads?.name || 'Customer Lead'}</div>
                      <div className="text-xs text-gray-500">{p.leads?.address || 'Phoenix, AZ'}</div>
                    </td>
                    <td className="px-4 py-4">
                      <StatusBadge status={p.status} />
                    </td>
                    <td className="px-4 py-4 text-right font-bold text-gray-900">
                      ${(p.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                    </td>
                    <td className="px-4 py-4 text-center">
                      {p.render_required ? (
                        <span className="inline-flex items-center text-[10px] font-bold bg-rose-100 text-rose-800 px-2 py-0.5 rounded border border-rose-300">
                          ⚠️ CARLOS RENDER
                        </span>
                      ) : (
                        <span className="text-xs text-gray-400">—</span>
                      )}
                    </td>
                    <td className="px-4 py-4 text-xs text-gray-500">
                      {new Date(p.created_at).toLocaleDateString()}
                    </td>
                    <td className="px-6 py-4 text-right">
                      <Link
                        href={`/proposals/${p.id}`}
                        className="text-xs font-bold text-emerald-600 hover:text-emerald-800 underline"
                      >
                        Open Proposal →
                      </Link>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
