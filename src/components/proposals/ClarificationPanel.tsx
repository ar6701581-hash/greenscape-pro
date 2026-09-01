'use client';

import React, { useState, useEffect } from 'react';

export interface ClarificationItem {
  id: string;
  original_extracted_name: string;
  question: string;
  proposed_catalog_item_id?: string;
  answer?: string;
  resolved: boolean;
}

interface CatalogItem {
  id: string;
  name: string;
  category: string;
  unit: string;
  unit_price: number;
}

interface ClarificationPanelProps {
  proposalId: string;
  clarifications: ClarificationItem[];
  isReadOnly: boolean;
  onRefresh: () => void;
}

export function ClarificationPanel({ proposalId, clarifications, isReadOnly, onRefresh }: ClarificationPanelProps) {
  const unresolved = clarifications.filter(c => !c.resolved);
  const [selectedClarificationId, setSelectedClarificationId] = useState<string | null>(null);
  const [catalogItems, setCatalogItems] = useState<CatalogItem[]>([]);
  const [selectedCatalogId, setSelectedCatalogId] = useState('');
  const [quantity, setQuantity] = useState(1);
  const [answerText, setAnswerText] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetch('/api/pricing-items')
      .then(res => res.json())
      .then(data => setCatalogItems(data.items || []))
      .catch(err => console.error(err));
  }, []);

  const handleResolve = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedClarificationId || !selectedCatalogId || quantity <= 0) return;
    setLoading(true);

    try {
      const res = await fetch(`/api/proposals/${proposalId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          action: 'RESOLVE_CLARIFICATION',
          clarificationId: selectedClarificationId,
          catalogItemId: selectedCatalogId,
          quantity,
          answer: answerText
        })
      });

      if (res.ok) {
        setSelectedClarificationId(null);
        setSelectedCatalogId('');
        setQuantity(1);
        setAnswerText('');
        onRefresh();
      } else {
        const err = await res.json();
        alert(`Failed to resolve clarification: ${err.error}`);
      }
    } finally {
      setLoading(false);
    }
  };

  if (unresolved.length === 0) {
    return null;
  }

  return (
    <div className="bg-amber-50/80 border-2 border-amber-300 rounded-xl p-5 shadow-sm space-y-4">
      <div className="flex items-center space-x-2">
        <span className="text-xl">💡</span>
        <div>
          <h3 className="font-bold text-amber-900 text-base">
            Action Required: {unresolved.length} Scope Clarification{unresolved.length > 1 ? 's' : ''}
          </h3>
          <p className="text-xs text-amber-800">
            Unresolved AI ambiguity or missing dimensions/materials must be answered before advancing to Review.
          </p>
        </div>
      </div>

      <div className="space-y-3">
        {unresolved.map(item => (
          <div key={item.id} className="bg-white p-4 rounded-lg border border-amber-200 shadow-sm space-y-2">
            <div className="flex justify-between items-start">
              <div>
                <span className="text-xs font-mono font-semibold bg-amber-100 text-amber-800 px-2 py-0.5 rounded">
                  {item.original_extracted_name}
                </span>
                <p className="text-sm font-bold text-gray-900 mt-1">{item.question}</p>
              </div>
              {!isReadOnly && selectedClarificationId !== item.id && (
                <button
                  onClick={() => {
                    setSelectedClarificationId(item.id);
                    if (item.proposed_catalog_item_id) {
                      setSelectedCatalogId(item.proposed_catalog_item_id);
                    }
                  }}
                  className="px-3 py-1.5 bg-amber-600 hover:bg-amber-700 text-white text-xs font-semibold rounded-lg shadow"
                >
                  Resolve Clarification
                </button>
              )}
            </div>

            {selectedClarificationId === item.id && (
              <form onSubmit={handleResolve} className="mt-3 pt-3 border-t border-amber-100 space-y-3">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  <div>
                    <label className="block text-xs font-semibold text-gray-700 mb-1">Match Catalog Item</label>
                    <select
                      value={selectedCatalogId}
                      onChange={e => setSelectedCatalogId(e.target.value)}
                      className="w-full border border-gray-300 rounded-lg px-2.5 py-1.5 text-xs"
                      required
                    >
                      <option value="">-- Choose Catalog Pricing Item --</option>
                      {catalogItems.map(cat => (
                        <option key={cat.id} value={cat.id}>
                          [{cat.category}] {cat.name} (${cat.unit_price}/{cat.unit})
                        </option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label className="block text-xs font-semibold text-gray-700 mb-1">Confirmed Quantity</label>
                    <input
                      type="number"
                      step="any"
                      min="0.1"
                      value={quantity}
                      onChange={e => setQuantity(parseFloat(e.target.value) || 0)}
                      className="w-full border border-gray-300 rounded-lg px-2.5 py-1.5 text-xs font-semibold"
                      required
                    />
                  </div>
                </div>

                <div>
                  <label className="block text-xs font-semibold text-gray-700 mb-1">Clarification Answer / Note</label>
                  <input
                    type="text"
                    placeholder="e.g. Aluminum pergola selected, 200 sq ft confirmed"
                    value={answerText}
                    onChange={e => setAnswerText(e.target.value)}
                    className="w-full border border-gray-300 rounded-lg px-2.5 py-1.5 text-xs"
                  />
                </div>

                <div className="flex justify-end space-x-2 pt-1">
                  <button
                    type="button"
                    onClick={() => setSelectedClarificationId(null)}
                    className="px-3 py-1 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-semibold rounded-lg"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    disabled={loading}
                    className="px-3 py-1 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-semibold rounded-lg shadow"
                  >
                    Confirm & Convert to Line Item
                  </button>
                </div>
              </form>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
