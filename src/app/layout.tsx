import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';
import { Sidebar } from '@/components/layout/Sidebar';
import { AppErrorBoundary } from '@/components/ui/AppErrorBoundary';

const inter = Inter({ subsets: ['latin'], variable: '--font-inter' });

export const metadata: Metadata = {
  title: 'Greenscape Pro — AI Proposal & Quote Drafting Agent',
  description: 'Turn site-walk notes into structured, priced proposals within hours.'
};

export default function RootLayout({
  children
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={inter.variable}>
      <body className="bg-slate-50 text-slate-900 antialiased font-sans flex min-h-screen">
        <Sidebar />
        <main className="flex-1 overflow-y-auto">
          <AppErrorBoundary>{children}</AppErrorBoundary>
        </main>
      </body>
    </html>
  );
}
