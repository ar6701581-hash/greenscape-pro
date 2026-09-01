'use client';

import React, { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';

interface Lead {
  id: string;
  name: string;
  address: string;
  city: string;
}

export default function NewProposalPage() {
  const router = useRouter();
  const [leads, setLeads] = useState<Lead[]>([]);
  const [selectedLeadId, setSelectedLeadId] = useState('');
  const [isNewLead, setIsNewLead] = useState(false);

  // New lead form inputs
  const [leadName, setLeadName] = useState('');
  const [leadAddress, setLeadAddress] = useState('');
  const [leadPhone, setLeadPhone] = useState('');
  const [leadEmail, setLeadEmail] = useState('');

  // Site walk notes
  const [rawNotes, setRawNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  useEffect(() => {
    fetch('/api/leads')
      .then(res => res.json())
      .then(data => {
        setLeads(data.leads || []);
        if (data.leads && data.leads.length > 0) {
          setSelectedLeadId(data.leads[0].id);
        } else {
          setIsNewLead(true);
        }
      })
      .catch(err => console.error(err));
  }, []);

  const wordCount = rawNotes.trim() ? rawNotes.trim().split(/\s+/).length : 0;
  const charCount = rawNotes.length;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg(null);

    if (!rawNotes.trim()) {
      setErrorMsg('Site-walk notes cannot be empty.');
      return;
    }

    if (charCount > 15000) {
      setErrorMsg('Notes exceed maximum length of 15,000 characters.');
      return;
    }

    setLoading(true);

    try {
      const payload: Record<string, unknown> = {
        rawNotes,
        leadId: isNewLead ? null : selectedLeadId
      };

      if (isNewLead) {
        payload.leadName = leadName;
        payload.leadAddress = leadAddress;
        payload.leadPhone = leadPhone;
        payload.leadEmail = leadEmail;
      }

      const res = await fetch('/api/proposals', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      const data = await res.json();

      if (!res.ok) {
        throw new Error(data.error || 'Failed to process site walk notes');
      }

      // Route to proposal review page
      router.push(`/proposals/${data.proposalId}`);
    } catch (err) {
      setErrorMsg((err as Error).message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-4xl mx-auto p-6 space-y-6">
      <div className="border-b border-gray-200 pb-4">
        <h1 className="text-2xl font-black text-gray-900">Create New Proposal</h1>
        <p className="text-xs text-gray-500 mt-1">
          Paste Marcus&apos;s raw site-walk notes. Gemini AI will interpret scope and match catalog items. Pricing is computed deterministically.
        </p>
      </div>

      {errorMsg && (
        <div className="bg-rose-50 border border-rose-200 text-rose-800 text-sm p-4 rounded-xl font-medium">
          ⚠️ {errorMsg}
        </div>
      )}

      <form onSubmit={handleSubmit} className="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm space-y-6">
        {/* Customer / Lead Selection */}
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <label className="text-sm font-bold text-gray-900">Customer Lead Information</label>
            <button
              type="button"
              onClick={() => setIsNewLead(!isNewLead)}
              className="text-xs font-semibold text-emerald-600 hover:text-emerald-800"
            >
              {isNewLead ? '← Select Existing Lead' : '+ Create New Lead'}
            </button>
          </div>

          {!isNewLead ? (
            <div>
              <select
                value={selectedLeadId}
                onChange={e => setSelectedLeadId(e.target.value)}
                className="w-full border border-gray-300 rounded-xl px-4 py-2.5 text-sm font-medium focus:ring-2 focus:ring-emerald-500"
                required
              >
                {leads.map(lead => (
                  <option key={lead.id} value={lead.id}>
                    {lead.name} — {lead.address}, {lead.city}
                  </option>
                ))}
              </select>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 bg-gray-50 p-4 rounded-xl border border-gray-200">
              <div>
                <label className="block text-xs font-semibold text-gray-700 mb-1">Customer Full Name *</label>
                <input
                  type="text"
                  placeholder="e.g. Marcus & Sarah Miller"
                  value={leadName}
                  onChange={e => setLeadName(e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                  required
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-700 mb-1">Property Street Address</label>
                <input
                  type="text"
                  placeholder="e.g. 7420 E Camelback Rd"
                  value={leadAddress}
                  onChange={e => setLeadAddress(e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-700 mb-1">Phone Number</label>
                <input
                  type="text"
                  placeholder="(602) 555-0199"
                  value={leadPhone}
                  onChange={e => setLeadPhone(e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-700 mb-1">Email Address</label>
                <input
                  type="email"
                  placeholder="miller@example.com"
                  value={leadEmail}
                  onChange={e => setLeadEmail(e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                />
              </div>
            </div>
          )}
        </div>

        {/* Site Walk Notes Textarea */}
        <div className="space-y-2">
          <div className="flex justify-between items-center">
            <label className="text-sm font-bold text-gray-900">Site-Walk Raw Notes *</label>
            <div className="text-xs text-gray-400">
              <span className={wordCount < 20 ? 'text-amber-600 font-semibold' : ''}>{wordCount} words</span> |{' '}
              <span className={charCount > 15000 ? 'text-rose-600 font-bold' : ''}>{charCount} / 15,000 chars</span>
            </div>
          </div>
          <textarea
            rows={8}
            placeholder="Paste raw notes from site walk... e.g. Customer wants 600 sq ft travertine pavers around the pool, 12x14 aluminum pergola over seating area, demo existing turf (800 sq ft), import 5 yards soil, gas fire pit with lava rock..."
            value={rawNotes}
            onChange={e => setRawNotes(e.target.value)}
            className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm focus:ring-2 focus:ring-emerald-500 font-mono"
            required
          />
          {wordCount > 0 && wordCount < 20 && (
            <p className="text-xs text-amber-700 bg-amber-50 px-3 py-1.5 rounded-lg border border-amber-200">
              ⚠️ Notes are brief ({wordCount} words). Extraction works best with detailed scope descriptions.
            </p>
          )}
        </div>

        {/* Submit button */}
        <div className="pt-2 flex justify-end">
          <button
            type="submit"
            disabled={loading || !rawNotes.trim()}
            className="w-full md:w-auto px-8 py-3 bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-sm rounded-xl shadow-lg disabled:opacity-50 transition flex items-center justify-center space-x-2"
          >
            {loading ? (
              <>
                <span className="animate-spin text-lg">⏳</span>
                <span>Extracting Scope & Computing Deterministic Pricing...</span>
              </>
            ) : (
              <span>Extract Scope & Draft Proposal →</span>
            )}
          </button>
        </div>
      </form>
    </div>
  );
}
