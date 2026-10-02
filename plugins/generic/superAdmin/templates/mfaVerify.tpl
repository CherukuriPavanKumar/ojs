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
    background: #1e2433;
    border: 1px solid #2e3650;
    border-radius: 16px;
    padding: 48px 40px;
    text-align: center;
    box-shadow: 0 8px 48px rgba(0,0,0,0.4);
}
.mfa-logo {
    width: 56px;
    height: 56px;
    background: linear-gradient(135deg, #6c63ff, #3b82f6);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;
    font-size: 24px;
}
.mfa-title {
    font-size: 22px;
    font-weight: 700;
    color: #f1f5f9;
    margin-bottom: 8px;
}
.mfa-subtitle {
    font-size: 14px;
    color: #8b96a7;
    margin-bottom: 28px;
    line-height: 1.6;
}
.mfa-input {
    width: 100%;
    padding: 16px;
    background: #151b2d;
    border: 1px solid #2e3650;
    border-radius: 10px;
    color: #f1f5f9;
    font-size: 28px;
    letter-spacing: 12px;
    text-align: center;
    margin-bottom: 16px;
    outline: none;
    transition: border-color 0.2s;
    box-sizing: border-box;
}
.mfa-input:focus { border-color: #6c63ff; }
.mfa-btn {
    width: 100%;
    padding: 14px;
    background: linear-gradient(135deg, #6c63ff, #3b82f6);
    border: none;
    border-radius: 10px;
    color: #fff;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: opacity 0.2s;
    margin-bottom: 12px;
}
.mfa-btn:hover { opacity: 0.88; }
.mfa-error {
    background: rgba(239,68,68,0.1);
    border: 1px solid rgba(239,68,68,0.35);
    color: #f87171;
    border-radius: 8px;
    padding: 12px 16px;
    font-size: 13px;
    margin-bottom: 16px;
}
.mfa-reset-link {
    display: block;
    font-size: 12px;
    color: #4b5563;
    text-decoration: none;
    margin-top: 12px;
    transition: color 0.2s;
}
.mfa-reset-link:hover { color: #f87171; }
.mfa-divider {
    border: none;
    border-top: 1px solid #2e3650;
    margin: 24px 0 20px;
}
.otp-timer {
    font-size: 12px;
    color: #4b5563;
    margin-bottom: 16px;
}
.otp-timer span {
    color: #6c63ff;
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
