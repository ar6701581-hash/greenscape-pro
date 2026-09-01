'use client';

import React, { useState, useEffect } from 'react';

export interface LineItem {
  id: string;
  name: string;
  category: string;
  unit: string;
  unit_price: number;
  quantity: number;
  line_total: number;
  ai_confidence?: number;
  ai_extracted_name?: string;
  out_of_range?: boolean;
  out_of_range_note?: string;
  is_manually_added?: boolean;
}

interface PricingCatalogItem {
  id: string;
  item_id: string;
  name: string;
  category: string;
  unit: string;
  unit_price: number;
}

interface LineItemEditorProps {
  proposalId: string;
  lineItems: LineItem[];
  isReadOnly: boolean;
  onRefresh: () => void;
}

export function LineItemEditor({ proposalId, lineItems, isReadOnly, onRefresh }: LineItemEditorProps) {
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editQty, setEditQty] = useState<number>(0);

  // Add line item modal state
  const [showAddModal, setShowAddModal] = useState(false);
  const [catalogItems, setCatalogItems] = useState<PricingCatalogItem[]>([]);
  const [selectedCatalogId, setSelectedCatalogId] = useState('');
  const [addQty, setAddQty] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (showAddModal) {
      fetchCatalogItems('');
    }
  }, [showAddModal]);

  const fetchCatalogItems = async (q: string) => {
    try {
      const res = await fetch(`/api/pricing-items?q=${encodeURIComponent(q)}`);
      const data = await res.json();
      setCatalogItems(data.items || []);
    } catch (err) {
      console.error('Failed to search catalog items:', err);
    }
  };

  const handleSaveQuantity = async (lineItemId: string) => {
    if (editQty <= 0) return;
    setLoading(true);

    try {
      const res = await fetch(`/api/proposals/${proposalId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'EDIT_QUANTITY', lineItemId, quantity: editQty })
      });

      if (res.ok) {
        setEditingId(null);
        onRefresh();
      } else {
        const err = await res.json();
        alert(`Failed to update quantity: ${err.error}`);
      }
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteLineItem = async (lineItemId: string) => {
    if (!confirm('Are you sure you want to remove this line item?')) return;
    setLoading(true);

    try {
      const res = await fetch(`/api/proposals/${proposalId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'DELETE_LINE_ITEM', lineItemId })
      });

      if (res.ok) {
        onRefresh();
      } else {
        const err = await res.json();
        alert(`Failed to delete item: ${err.error}`);
      }
    } finally {
      setLoading(false);
    }
  };

  const handleAddLineItemSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedCatalogId || addQty <= 0) return;
    setLoading(true);

    try {
      const res = await fetch(`/api/proposals/${proposalId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'ADD_LINE_ITEM', catalogItemId: selectedCatalogId, quantity: addQty })
      });

      if (res.ok) {
        setShowAddModal(false);
        setSelectedCatalogId('');
        setAddQty(1);
        onRefresh();
      } else {
        const err = await res.json();
        alert(`Failed to add line item: ${err.error}`);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-white rounded-xl shadow-sm border border-emerald-100 overflow-hidden">
      <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between bg-emerald-50/40">
        <div>
          <h3 className="font-bold text-gray-900">Line Item Scope & Pricing</h3>
          <p className="text-xs text-gray-500">Unit prices sourced deterministically from DB catalog.</p>
        </div>
        {!isReadOnly && (
          <button
            onClick={() => setShowAddModal(true)}
            className="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-semibold rounded-lg shadow transition"
          >
            + Add Line Item
          </button>
        )}
      </div>

      <div className="overflow-x-auto">
        <table className="w-full text-left text-sm text-gray-700">
          <thead className="bg-gray-50 text-xs font-bold text-gray-600 uppercase border-b">
            <tr>
              <th className="px-6 py-3">Item & Category</th>
              <th className="px-4 py-3">Extracted Term</th>
              <th className="px-4 py-3 text-right">Unit Price</th>
              <th className="px-4 py-3 text-center">Quantity / Unit</th>
              <th className="px-6 py-3 text-right">Total</th>
              {!isReadOnly && <th className="px-4 py-3 text-center">Actions</th>}
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {lineItems.length === 0 ? (
              <tr>
                <td colSpan={6} className="px-6 py-8 text-center text-gray-400">
                  No calculated line items yet. Resolve pending clarifications or add items manually.
                </td>
              </tr>
            ) : (
              lineItems.map(item => (
                <tr key={item.id} className="hover:bg-gray-50/50 transition">
                  <td className="px-6 py-4">
                    <div className="font-semibold text-gray-900 flex items-center gap-1.5">
                      {item.name}
                      {item.is_manually_added && (
                        <span className="text-[10px] bg-purple-100 text-purple-700 px-1.5 py-0.5 rounded">Manual</span>
                      )}
                    </div>
                    <div className="text-xs text-gray-500">{item.category}</div>
                    {item.out_of_range && (
                      <div className="mt-1 text-xs text-amber-700 bg-amber-50 px-2 py-0.5 rounded border border-amber-200">
                        ⚠️ {item.out_of_range_note}
                      </div>
                    )}
                  </td>
                  <td className="px-4 py-4 text-xs text-gray-500 font-mono">
                    {item.ai_extracted_name || '—'}
                  </td>
                  <td className="px-4 py-4 text-right font-medium text-gray-900">
                    ${item.unit_price.toFixed(2)}
                  </td>
                  <td className="px-4 py-4 text-center">
                    {editingId === item.id ? (
                      <div className="flex items-center justify-center space-x-1">
                        <input
                          type="number"
                          step="any"
                          value={editQty}
                          onChange={e => setEditQty(parseFloat(e.target.value) || 0)}
                          className="w-20 px-2 py-1 border border-emerald-300 rounded text-center text-sm font-semibold"
                        />
                        <span className="text-xs text-gray-500">{item.unit}</span>
                        <button
                          onClick={() => handleSaveQuantity(item.id)}
                          disabled={loading}
                          className="px-2 py-1 bg-emerald-600 text-white text-xs rounded hover:bg-emerald-700"
                        >
                          Save
                        </button>
                        <button
                          onClick={() => setEditingId(null)}
                          className="px-2 py-1 bg-gray-200 text-gray-700 text-xs rounded"
                        >
                          Cancel
                        </button>
                      </div>
                    ) : (
                      <div className="font-semibold text-gray-900">
                        {item.quantity} <span className="text-xs font-normal text-gray-500">{item.unit}</span>
                      </div>
                    )}
                  </td>
                  <td className="px-6 py-4 text-right font-bold text-emerald-700 text-base">
                    ${item.line_total.toFixed(2)}
                  </td>
                  {!isReadOnly && (
                    <td className="px-4 py-4 text-center">
                      <div className="flex items-center justify-center space-x-2">
                        <button
                          onClick={() => {
                            setEditingId(item.id);
                            setEditQty(item.quantity);
                          }}
                          className="text-xs font-semibold text-blue-600 hover:text-blue-800"
                        >
                          Edit Qty
                        </button>
                        <button
                          onClick={() => handleDeleteLineItem(item.id)}
                          className="text-xs font-semibold text-rose-600 hover:text-rose-800"
                        >
                          Delete
                        </button>
                      </div>
                    </td>
                  )}
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Add Line Item Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black/40 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-xl shadow-2xl max-w-lg w-full p-6 space-y-4">
            <h3 className="text-lg font-bold text-gray-900">Add Item from Pricing Catalog</h3>
            
            <div>
              <label className="block text-xs font-semibold text-gray-700 mb-1">Search Catalog</label>
              <input
                type="text"
                placeholder="Search pavers, turf, pool, pergolas..."
                value={searchQuery}
                onChange={e => {
                  setSearchQuery(e.target.value);
                  fetchCatalogItems(e.target.value);
                }}
                className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-emerald-500"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-gray-700 mb-1">Select Catalog Item</label>
              <select
                value={selectedCatalogId}
                onChange={e => setSelectedCatalogId(e.target.value)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm max-h-40"
              >
                <option value="">-- Choose Catalog Item --</option>
                {catalogItems.map(item => (
                  <option key={item.id} value={item.id}>
                    [{item.category}] {item.name} (${item.unit_price} / {item.unit})
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-xs font-semibold text-gray-700 mb-1">Quantity</label>
              <input
                type="number"
                step="any"
                min="0.1"
                value={addQty}
                onChange={e => setAddQty(parseFloat(e.target.value) || 0)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
              />
            </div>

            <div className="flex justify-end space-x-3 pt-4 border-t">
              <button
                type="button"
                onClick={() => setShowAddModal(false)}
                className="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm font-semibold rounded-lg"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={handleAddLineItemSubmit}
                disabled={loading || !selectedCatalogId}
                className="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-semibold rounded-lg disabled:opacity-50"
              >
                Add Item
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
