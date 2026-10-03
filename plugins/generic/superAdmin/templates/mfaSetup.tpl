{**
 * templates/mfaSetup.tpl
 *
 * MFA Setup page — shown on first Super Admin login.
 * Displays a QR code for the admin to scan with their authenticator app.
 *}
{include file="layouts/backend.tpl"}
{block name="page"}

<style>
.mfa-wrap {
    max-width: 480px;
    margin: 60px auto;
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
.mfa-steps {
    text-align: left;
    background: #1E293B;
    border: 1px solid #334155;
    border-radius: 6px;
    padding: 20px 24px;
    margin-bottom: 24px;
}
.mfa-steps li {
    color: #E2E8F0;
    font-size: 13.5px;
    margin-bottom: 10px;
    line-height: 1.5;
}
.mfa-steps li:last-child { margin-bottom: 0; }
.mfa-qr {
    background: #fff;
    border-radius: 8px;
    padding: 16px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
    min-width: 200px;
    min-height: 200px;
}
.manual-secret {
    background: #1E293B;
    border: 1px dashed #C9A84C;
    border-radius: 6px;
    padding: 10px 14px;
    font-family: monospace;
    font-size: 13px;
    color: #C9A84C;
    letter-spacing: 1px;
    margin-bottom: 24px;
    word-break: break-all;
}
.mfa-input {
    width: 100%;
    padding: 14px 16px;
    background: #1E293B;
    border: 1px solid #334155;
    border-radius: 6px;
    color: #FFFFFF;
    font-size: 22px;
    letter-spacing: 8px;
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
</style>

<div class="mfa-wrap">
    <div class="mfa-logo">🔐</div>
    <div class="mfa-title">Set Up Two-Factor Authentication</div>
    <div class="mfa-subtitle">
        Protect your Super Admin account with an authenticator app.<br>
        This only needs to be done once.
    </div>

    <ol class="mfa-steps">
        <li>Install <strong>Google Authenticator</strong>, <strong>Authy</strong>, or any TOTP app on your phone.</li>
        <li>Scan the QR code below, or enter the secret key manually.</li>
        <li>Enter the 6-digit code shown in your app to confirm setup.</li>
    </ol>

    <div class="mfa-qr" id="qrcode-container"></div>

    <div style="color:#8b96a7;font-size:12px;margin-bottom:8px;">Can't scan? Enter this key manually:</div>
    <div class="manual-secret">{$manualSecret|escape}</div>

    {if $error}
        <div class="mfa-error">{$error|escape}</div>
    {/if}

    <form method="post" action="{$confirmUrl|escape}">
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
        <button class="mfa-btn" type="submit">Confirm &amp; Enable MFA</button>
    </form>
</div>

<script src="{$pluginUrl|escape}/public/js/qrcode.min.js"></script>
<script>
(function() {
    var otpUri = {$otpAuthUri|json_encode};
    new QRCode(document.getElementById('qrcode-container'), {
        text: otpUri,
        width: 200,
        height: 200,
        colorDark: '#000000',
        colorLight: '#ffffff',
        correctLevel: QRCode.CorrectLevel.M
    });
})();
</script>

{/block}
