{**
 * templates/frontend/pages/userLogin.tpl
 * Overridden by Veridica Custom Theme for a premium login card
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

	</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

<div class="veridica-login-page">
    <div class="veridica-login-card">
        <div class="v-login-branding">
            <h2>Veridica Publishing</h2>
            <p>Access your dashboard to submit manuscripts, manage peer reviews, and track your publications.</p>
            <ul class="v-login-features">
                <li><i class="fas fa-check-circle"></i> Rapid Peer Review</li>
                <li><i class="fas fa-check-circle"></i> Global Reach</li>
                <li><i class="fas fa-check-circle"></i> Open Access</li>
            </ul>
        </div>
        
        <div class="v-login-form-container">
            <div class="v-login-header">
                <h1>{translate key="user.login"}</h1>
                <p>Welcome back to Veridica</p>
            </div>

        {if $loginMessage}
            <div class="cmp_notification notice">
                {translate key=$loginMessage}
            </div>
        {/if}

        {if $error}
            <div class="pkp_form_error cmp_notification error">
                {translate key=$error reason=$reason}
            </div>
        {/if}

        <form class="cmp_form login" id="login" method="post" action="{$loginUrl}" role="form">
            {csrf}
            <input type="hidden" name="source" value="{$source|default:""|escape}" />

            <fieldset class="fields">
                <legend class="pkp_screen_reader">{translate key="user.login"}</legend>
                
                <div class="v-form-group">
                    <label for="username">
                        {translate key="user.usernameOrEmail"} <span class="required">*</span>
                    </label>
                    <input type="text" name="username" id="username" value="{$username|default:""|escape}" required aria-required="true" autocomplete="username">
                </div>

                <div class="v-form-group">
                    <label for="password">
                        {translate key="user.password"} <span class="required">*</span>
                    </label>
                    <input type="password" name="password" id="password" value="{$password|default:""|escape}" maxlength="32" required aria-required="true" autocomplete="current-password">
                    <div class="v-form-forgot">
                        <a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a>
                    </div>
                </div>

                <div class="v-form-group checkbox">
                    <label>
                        <input type="checkbox" name="remember" id="remember" value="1" checked="$remember">
                        <span class="label">{translate key="user.login.rememberUsernameAndPassword"}</span>
                    </label>
                </div>

                {* recaptcha spam blocker *}
                {if $recaptchaPublicKey}
                    <fieldset class="recaptcha_wrapper">
                        <div class="fields">
                            <div class="recaptcha">
                                <div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div>
                                <label for="g-recaptcha-response" style="display:none;" hidden>Recaptcha response</label>
                            </div>
                        </div>
                    </fieldset>
                {/if}

                {* altcha spam blocker *}
                {if $altchaEnabled}
                    <fieldset class="altcha_wrapper">
                        <div class="fields">
                            <altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
                        </div>
                    </fieldset>
                {/if}

                <div class="v-login-actions">
                    <button class="veridica-btn-primary" type="submit">
                        {translate key="user.login"} <i class="fas fa-arrow-right"></i>
                    </button>
                    {if !$disableUserReg}
                        {capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
                        <p class="v-login-register">
                            Don't have an account? <a href="{$registerUrl}">{translate key="user.login.registerNewAccount"}</a>
                        </p>
                    {/if}
                </div>
            </fieldset>
        </form>
        </div><!-- v-login-form-container -->
    </div>
</div>

<div class="pkp_structure_content">
	<div class="pkp_structure_main" role="main">

{include file="frontend/components/footer.tpl"}
