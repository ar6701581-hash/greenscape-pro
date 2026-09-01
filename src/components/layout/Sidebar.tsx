import React from 'react';
import Link from 'next/link';

export function Sidebar() {
  return (
    <aside className="w-64 bg-slate-900 text-slate-300 min-h-screen p-5 flex flex-col justify-between border-r border-slate-800">
      <div className="space-y-8">
        <div>
          <div className="text-white font-black text-lg tracking-tight flex items-center gap-2">
            <span>🌿</span> Greenscape Pro
          </div>
          <div className="text-[11px] text-emerald-400 font-semibold tracking-wider uppercase mt-0.5">
            Proposal Agent Operations
          </div>
        </div>

        <nav className="space-y-1">
          <Link
            href="/"
            className="flex items-center space-x-3 px-3 py-2.5 rounded-xl text-xs font-bold text-slate-200 hover:bg-slate-800 hover:text-white transition"
          >
            <span>📊</span>
            <span>Dashboard</span>
          </Link>
          <Link
            href="/proposals/new"
            className="flex items-center space-x-3 px-3 py-2.5 rounded-xl text-xs font-bold text-slate-200 hover:bg-slate-800 hover:text-white transition"
          >
            <span>➕</span>
            <span>New Proposal</span>
          </Link>
        </nav>
      </div>

      <div className="pt-6 border-t border-slate-800 text-[11px] text-slate-500 space-y-1">
        <div>Operator: Marcus Tate</div>
        <div>Mode: Internal Operations</div>
        <div>Model: Gemini 3.6 Flash</div>
      </div>
    </aside>
  );
}
