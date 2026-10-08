'use client';

import { useState } from 'react';
import { signIn } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import { ShieldCheck, Mail, Lock, KeyRound, BookOpen, AlertCircle, RefreshCw } from 'lucide-react';
import toast from 'react-hot-toast';

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [code, setCode] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const result = await signIn('credentials', {
        email,
        password,
        code,
        redirect: false,
      });

      if (result?.error) {
        const errorMsg = 'Authentication failed. Please check your credentials and TOTP code.';
        setError(errorMsg);
        toast.error(errorMsg);
        setLoading(false);
      } else {
        toast.success('Authentication successful! Welcome to Super Admin Vault.');
        router.push('/dashboard');
      }
    } catch (err) {
      const errorMsg = 'An unexpected error occurred during authentication.';
      setError(errorMsg);
      toast.error(errorMsg);
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#F2F5F3] flex flex-col justify-center items-center p-4 relative overflow-hidden font-sans">
      {/* Background Subtle Institutional Ambient Details */}
      <div className="absolute -top-32 -left-32 w-96 h-96 bg-[#1E3D30]/5 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute -bottom-32 -right-32 w-96 h-96 bg-[#D8E3DA]/40 rounded-full blur-3xl pointer-events-none" />

      {/* Main Login Card - Light Tone Concept 3: Cambridge Stone & Forest Green */}
      <div className="bg-white rounded-xl shadow-xl shadow-emerald-950/5 p-8 sm:p-10 w-full max-w-md border border-[#D5DED6] z-10 relative">
        {/* Brand Header */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center justify-center w-14 h-14 rounded-lg bg-[#1E3D30] text-[#DDEBE3] mb-4 shadow-sm">
            <BookOpen className="w-7 h-7 text-[#DDEBE3]" />
          </div>
          <div className="flex items-center justify-center gap-1.5 mb-1.5">
            <span className="px-2.5 py-0.5 rounded-sm text-[10px] font-bold tracking-widest uppercase bg-[#E8EFEA] text-[#1E3D30] border border-[#CCD5CC]">
              VERIDICA ACADEMIC GOVERNANCE
            </span>
          </div>
          <h1 className="text-2xl font-serif font-bold text-[#142820] tracking-tight">
            Veridica Academic Network
          </h1>
          <p className="text-[#556B60] text-xs mt-1 font-medium font-sans">
            Institutional Super Admin Governance Vault
          </p>
        </div>

        {/* Login Form */}
        <form onSubmit={handleSubmit} className="space-y-5">
          <div>
            <label className="block text-xs font-bold text-[#1E3D30] uppercase tracking-wider mb-1.5 flex items-center gap-1.5">
              <Mail className="w-3.5 h-3.5 text-[#1E3D30]" /> Admin Email Address
            </label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="admin@veridica.com"
              className="w-full border border-[#C5D0C6] rounded-md px-4 py-3 text-xs font-medium text-[#142820] focus:outline-none focus:border-[#1E3D30] focus:ring-2 focus:ring-[#1E3D30]/15 transition-all bg-[#F9FAF9] focus:bg-white placeholder:text-slate-400"
              required
            />
          </div>

          <div>
            <label className="block text-xs font-bold text-[#1E3D30] uppercase tracking-wider mb-1.5 flex items-center gap-1.5">
              <Lock className="w-3.5 h-3.5 text-[#1E3D30]" /> Account Password
            </label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••••••"
              className="w-full border border-[#C5D0C6] rounded-md px-4 py-3 text-xs font-medium text-[#142820] focus:outline-none focus:border-[#1E3D30] focus:ring-2 focus:ring-[#1E3D30]/15 transition-all bg-[#F9FAF9] focus:bg-white placeholder:text-slate-400"
              required
            />
          </div>

          <div>
            <div className="flex items-center justify-between mb-1.5">
              <label className="block text-xs font-bold text-[#1E3D30] uppercase tracking-wider flex items-center gap-1.5">
                <KeyRound className="w-3.5 h-3.5 text-[#1E3D30]" /> TOTP 2FA Authenticator Code
              </label>
              <span className="text-[10px] text-[#556B60] font-medium">(Required if active)</span>
            </div>
            <input
              type="text"
              value={code}
              onChange={(e) => setCode(e.target.value)}
              placeholder="6-digit TOTP code (e.g. 123456)"
              maxLength={6}
              className="w-full border border-[#C5D0C6] rounded-md px-4 py-3 text-sm font-mono tracking-[0.2em] font-bold text-[#142820] focus:outline-none focus:border-[#1E3D30] focus:ring-2 focus:ring-[#1E3D30]/15 transition-all bg-[#F9FAF9] focus:bg-white placeholder:text-slate-400"
            />
          </div>

          {error && (
            <div className="p-3.5 rounded-md bg-rose-50 border border-rose-200 text-rose-700 text-xs font-semibold flex items-center gap-2">
              <AlertCircle className="w-4 h-4 shrink-0 text-rose-600" />
              <span>{error}</span>
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-[#1E3D30] hover:bg-[#142820] text-white py-3.5 rounded-md font-bold text-xs uppercase tracking-wider transition-all shadow-sm focus:outline-none focus:ring-2 focus:ring-[#1E3D30] focus:ring-offset-2 disabled:opacity-50 flex items-center justify-center gap-2 cursor-pointer"
          >
            {loading ? (
              <>
                <RefreshCw className="w-4 h-4 animate-spin text-white" /> Verifying Credentials...
              </>
            ) : (
              <>
                <ShieldCheck className="w-4 h-4 text-emerald-300" /> Authorize & Sign In
              </>
            )}
          </button>
        </form>

        {/* Security Compliance Footer */}
        <div className="mt-8 pt-6 border-t border-[#E5EDE6] text-center space-y-2">
          <div className="flex items-center justify-center gap-1.5 text-[11px] text-[#4B6356] font-medium">
            <ShieldCheck className="w-3.5 h-3.5 text-[#1E3D30]" /> 256-bit SSL Encrypted
          </div>
          <p className="text-[10px] text-[#83998D]">
            Veridica Academic Publishing Security &copy; 2026
          </p>
        </div>
      </div>
    </div>
  );
}
