{**
 * templates/mfaVerify.tpl
 *
 * MFA Verify page — shown every login session until OTP is entered correctly.
 *}
{include file="layouts/backend.tpl"}
{block name="page"}

<style>
.mfa-wrap {
    max-width: 420px;
    margin: 80px auto;
    background: #0F172A;
    border: 1px solid #1E293B;
    border-radius: 8px;
    padding: 48px 40px;
    text-align: center;
    box-shadow: 0 4px 20px rgba(15, 23, 42, 0.2);
    font-family: 'Inter', sans-serif;
}
.mfa-logo {
    width: 56px;
    height: 56px;
    background: #C9A84C;
    color: #0F172A;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;
    font-size: 24px;
}
.mfa-title {
    font-family: 'Merriweather', Georgia, serif;
    font-size: 22px;
    font-weight: 700;
    color: #FFFFFF;
    margin-bottom: 8px;
}
.mfa-subtitle {
    font-size: 14px;
    color: #94A3B8;
    margin-bottom: 28px;
    line-height: 1.6;
}
.mfa-input {
    width: 100%;
    padding: 16px;
    background: #1E293B;
    border: 1px solid #334155;
    border-radius: 6px;
    color: #FFFFFF;
    font-size: 28px;
    letter-spacing: 12px;
    text-align: center;
    margin-bottom: 16px;
    outline: none;
    transition: border-color 0.2s;
    box-sizing: border-box;
}
.mfa-input:focus { border-color: #C9A84C; box-shadow: 0 0 0 2px rgba(201, 168, 76, 0.2); }
.mfa-btn {
    width: 100%;
    padding: 14px;
    background: #C9A84C;
    border: none;
    border-radius: 6px;
    color: #0F172A;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.2s;
    margin-bottom: 12px;
}
.mfa-btn:hover { background: #B48A3C; color: #FFFFFF; }
.mfa-error {
    background: rgba(153,27,27,0.2);
    border: 1px solid rgba(153,27,27,0.5);
    color: #FCA5A5;
    border-radius: 6px;
    padding: 12px 16px;
    font-size: 13px;
    margin-bottom: 16px;
}
.mfa-reset-link {
    display: block;
    font-size: 12px;
    color: #94A3B8;
    text-decoration: none;
    margin-top: 12px;
    transition: color 0.2s;
}
.mfa-reset-link:hover { color: #FCA5A5; }
.mfa-divider {
    border: none;
    border-top: 1px solid #1E293B;
    margin: 24px 0 20px;
}
.otp-timer {
    font-size: 12px;
    color: #94A3B8;
    margin-bottom: 16px;
}
.otp-timer span {
    color: #C9A84C;
    font-weight: 600;
}
</style>

<div class="mfa-wrap">
    <div class="mfa-logo">🛡️</div>
    <div class="mfa-title">Verify Your Identity</div>
    <div class="mfa-subtitle">
        Enter the 6-digit code from your authenticator app to access the Super Admin Panel.
    </div>

    {if $error}
        <div class="mfa-error">{$error|escape}</div>
    {/if}

    <div class="otp-timer">
        Code refreshes in <span id="otp-countdown">--</span> seconds
    </div>

    <form method="post" action="{$verifyUrl|escape}">
        {csrf}
        <input
            class="mfa-input"
            type="text"
            name="code"
            id="mfa-code"
            maxlength="6"
            placeholder="000000"
            autocomplete="one-time-code"
            inputmode="numeric"
            autofocus
            required
        />
        <button class="mfa-btn" type="submit">Verify &amp; Continue</button>
    </form>

    <hr class="mfa-divider">
    <div style="color:#8b96a7;font-size:12px;">Lost access to your authenticator app?</div>
    <a class="mfa-reset-link" href="{$resetUrl|escape}" onclick="return confirm('This will remove your current MFA device and force re-registration. Continue?')">
        ⚠ Reset MFA device
    </a>
</div>

<script>
// Live countdown to the next TOTP window (30s period)
(function() {
    var countdown = document.getElementById('otp-countdown');
    function tick() {
        var remaining = 30 - (Math.floor(Date.now() / 1000) % 30);
        countdown.textContent = remaining;
        if (remaining <= 5) {
            countdown.style.color = '#f87171';
        } else {
            countdown.style.color = '#6c63ff';
        }
        setTimeout(tick, 1000);
    }
    tick();
})();
</script>

{/block}
