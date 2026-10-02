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
.mfa-steps {
    text-align: left;
    background: #151b2d;
    border-radius: 10px;
    padding: 20px 24px;
    margin-bottom: 24px;
}
.mfa-steps li {
    color: #c9d4e3;
    font-size: 13.5px;
    margin-bottom: 10px;
    line-height: 1.5;
}
.mfa-steps li:last-child { margin-bottom: 0; }
.mfa-qr {
    background: #fff;
    border-radius: 12px;
    padding: 16px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
    min-width: 200px;
    min-height: 200px;
}
.manual-secret {
    background: #151b2d;
    border: 1px dashed #3b4568;
    border-radius: 8px;
    padding: 10px 14px;
    font-family: monospace;
    font-size: 13px;
    color: #6c63ff;
    letter-spacing: 1px;
    margin-bottom: 24px;
    word-break: break-all;
}
.mfa-input {
    width: 100%;
    padding: 14px 16px;
    background: #151b2d;
    border: 1px solid #2e3650;
    border-radius: 10px;
    color: #f1f5f9;
    font-size: 22px;
    letter-spacing: 8px;
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
