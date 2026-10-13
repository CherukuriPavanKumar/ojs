{**
 * templates/mfaVerify.tpl
 *
 * SAGE / Scopus Academic MFA Verify page — shown every login session until OTP is verified.
 *}
{include file="layouts/backend.tpl"}
{block name="page"}

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Lora:ital,wght@0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">

<style>
{literal}
.mfa-verify-container {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    min-height: 85vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
    background: #F8F9FA;
}
.mfa-verify-card {
    max-width: 440px;
    width: 100%;
    background: #FFFFFF;
    border: 1px solid #E2E8F0;
    border-top: 4px solid #003366;
    border-radius: 8px;
    padding: 40px 36px;
    text-align: center;
    box-shadow: 0 10px 25px -5px rgba(0,0,0,0.06), 0 8px 10px -6px rgba(0,0,0,0.04);
}
.mfa-verify-emblem {
    width: 52px;
    height: 52px;
    background: #003366;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 16px;
    color: #C9A84C;
}
.mfa-verify-badge {
    display: inline-block;
    background: #EFF6FF;
    color: #1E40AF;
    border: 1px solid #BFDBFE;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.05em;
    padding: 3px 10px;
    border-radius: 20px;
    text-transform: uppercase;
    margin-bottom: 8px;
}
.mfa-verify-title {
    font-family: 'Lora', Georgia, serif;
    font-size: 22px;
    font-weight: 700;
    color: #0F172A;
    margin: 0 0 6px 0;
}
.mfa-verify-subtitle {
    font-size: 13px;
    color: #64748B;
    margin-bottom: 24px;
    line-height: 1.5;
}
.mfa-verify-input {
    width: 100%;
    padding: 14px 16px;
    background: #FFFFFF;
    border: 1.5px solid #CBD5E1;
    border-radius: 6px;
    color: #0F172A;
    font-size: 26px;
    font-weight: 700;
    letter-spacing: 10px;
    text-align: center;
    margin-bottom: 16px;
    outline: none;
    transition: all 0.2s;
    box-sizing: border-box;
}
.mfa-verify-input:focus {
    border-color: #003366;
    box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.15);
}
.mfa-verify-btn {
    width: 100%;
    padding: 12px;
    background: #003366;
    border: 1px solid #002244;
    border-radius: 6px;
    color: #FFFFFF;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.18s;
}
.mfa-verify-btn:hover { background: #002244; }
.mfa-verify-btn:focus-visible {
    outline: 2px solid #003366;
    outline-offset: 2px;
}
.mfa-verify-error {
    background: #FEE2E2;
    border: 1px solid #FCA5A5;
    color: #991B1B;
    border-radius: 6px;
    padding: 10px 14px;
    font-size: 13px;
    margin-bottom: 16px;
    text-align: left;
}
.otp-timer {
    font-size: 12px;
    color: #64748B;
    margin-bottom: 18px;
}
.otp-timer span {
    color: #003366;
    font-weight: 700;
}
.mfa-divider {
    border: none;
    border-top: 1px solid #E2E8F0;
    margin: 24px 0 16px;
}
.mfa-reset-link {
    display: inline-block;
    font-size: 12px;
    color: #64748B;
    text-decoration: underline;
    transition: color 0.15s;
    cursor: pointer;
}
.mfa-reset-link:hover { color: #DC2626; }
{/literal}
</style>

<div class="mfa-verify-container">
    <div class="mfa-verify-card">
        <div class="mfa-verify-emblem">
            <svg width="26" height="26" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path></svg>
        </div>
        <span class="mfa-verify-badge">Identity Verification</span>
        <h1 class="mfa-verify-title">Verify Your Security Code</h1>
        <p class="mfa-verify-subtitle">
            Enter the 6-digit TOTP verification code from your authenticator app to access the Super Admin Oversight Panel.
        </p>

        {if $error}
            <div class="mfa-verify-error" role="alert">{$error|escape}</div>
        {/if}

        <div class="otp-timer">
            Security window refreshes in <span id="otp-countdown">--</span> seconds
        </div>

        <form method="post" action="{$verifyUrl|escape}">
            {csrf}
            <input
                class="mfa-verify-input"
                type="text"
                name="code"
                id="mfa-code"
                maxlength="6"
                placeholder="000000"
                autocomplete="one-time-code"
                inputmode="numeric"
                aria-label="6-digit Authenticator Code"
                autofocus
                required
            />
            <button class="mfa-verify-btn" type="submit">Verify &amp; Continue to Dashboard</button>
        </form>

        <hr class="mfa-divider">
        <div style="color: #64748B; font-size: 12px; margin-bottom: 4px;">Lost access to your authenticator app?</div>
        <a class="mfa-reset-link" href="{$resetUrl|escape}" onclick="return confirm('This will remove your current MFA device and force re-registration upon next login. Continue?')">
            Reset MFA Device Registration
        </a>
    </div>
</div>

<script>
{literal}
(function() {
    var countdown = document.getElementById('otp-countdown');
    function tick() {
        var remaining = 30 - (Math.floor(Date.now() / 1000) % 30);
        if (countdown) {
            countdown.textContent = remaining;
            countdown.style.color = (remaining <= 5) ? '#DC2626' : '#003366';
        }
        setTimeout(tick, 1000);
    }
    tick();
})();
{/literal}
</script>

{/block}
