{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 * @uses $primaryLocale string The primary locale for this journal/press
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

	</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

{assign var="siteContextId" value=PKP\core\PKPApplication::SITE_CONTEXT_ID|intval}

<div class="veridica-login-page">
    <div class="veridica-login-card veridica-register-card">
        <div class="v-login-branding">
            <h2>Veridica Publishing</h2>
            <p>Create an account to submit manuscripts, participate in peer review, and engage with global research.</p>
            <ul class="v-login-features">
                <li><i class="fas fa-file-alt"></i> Streamlined Submissions</li>
                <li><i class="fas fa-users"></i> Expert Peer Review</li>
                <li><i class="fas fa-chart-line"></i> Advanced Article Metrics</li>
            </ul>
        </div>

        <div class="v-login-form-container">
            <div class="v-login-header">
                <h1>{translate key="user.register"}</h1>
                <p>Join the Veridica network today.</p>
            </div>

	<form class="cmp_form register" id="register" method="post" action="{url op="register"}" role="form">
		{if $orcidEnabled}
			{include file="form/orcidProfile.tpl"}
		{/if}

		{csrf}

		{if $source}
			<input type="hidden" name="source" value="{$source|escape}" />
		{/if}

		{include file="common/formErrors.tpl"}

		{include file="frontend/components/registrationForm.tpl"}

		{* When a user is registering with a specific journal *}
		{if $currentContext}

			<fieldset class="consent">
				{if $currentContext->getData('privacyStatement')}
					{* Require the user to agree to the terms of the privacy policy *}
					<legend class="pkp_screen_reader">{translate key="user.register.form.privacyConsentLabel"}</legend>
					<div class="fields">
						<div class="optin optin-privacy">
							<label>
								<input type="checkbox" name="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}>
								{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
								{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
							</label>
						</div>
					</div>
				{/if}
				{* Ask the user to opt into public email notifications *}
				<div class="fields">
					<div class="optin optin-email">
						<label>
							<input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
							{translate key="user.register.form.emailConsent"}
						</label>
					</div>
				</div>
			</fieldset>

			{* Allow the user to sign up as a reviewer *}
			{assign var=contextId value=$currentContext->getId()}
			{assign var=userCanRegisterReviewer value=0}
			{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
				{if $userGroup->permitSelfRegistration}
					{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
				{/if}
			{/foreach}
			{if $userCanRegisterReviewer}
				<fieldset class="reviewer">
					{if $userCanRegisterReviewer > 1}
						<legend>
							{translate key="user.reviewerPrompt"}
						</legend>
						{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
					{else}
						{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
					{/if}
					<div class="fields">
						<div id="reviewerOptinGroup" class="optin">
							{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
								{if $userGroup->permitSelfRegistration}
									<label>
										{assign var="userGroupId" value=$userGroup->id}
										<input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
										{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedData('name')}
									</label>
								{/if}
							{/foreach}
						</div>
						<div id="reviewerInterests" class="reviewer_interests">
							<label>
								<span class="label">
									{translate key="user.interests"}
								</span>
								<input type="text" name="interests" id="interests" value="{$interests|default:""|escape}">
							</label>
						</div>
					</div>
				</fieldset>
			{/if}
		{/if}

		{include file="frontend/components/registrationFormContexts.tpl"}

		{* When a user is registering for no specific journal, allow them to
		   enter their reviewer interests *}
		{if !$currentContext}
			<div class="fields">
				<div class="reviewer_nocontext_interests">
					<label>
						<span class="label">
							{translate key="user.register.noContextReviewerInterests"}
						</span>
						<input type="text" name="interests" id="interests" value="{$interests|default:""|escape}">
					</label>
				</div>
			</div>

			{* Require the user to agree to the terms of the privacy policy *}
			{if $siteWidePrivacyStatement}
				<div class="fields">
					<div class="optin optin-privacy">
						<label>
							<input type="checkbox" name="privacyConsent[{$siteContextId}]" id="privacyConsent[{$siteContextId}]" value="1"{if $privacyConsent[$siteContextId]} checked="checked"{/if}>
							{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
							{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
						</label>
					</div>
				</div>
			{/if}

			{* Ask the user to opt into public email notifications *}
			<div class="fields">
				<div class="optin optin-email">
					<label>
						<input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
						{translate key="user.register.form.emailConsent"}
					</label>
				</div>
			</div>
		{/if}

		{* recaptcha spam blocker *}
		{if $recaptchaPublicKey}
			<fieldset class="recaptcha_wrapper">
				<div class="fields">
					<div class="recaptcha">
						<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}">
						</div><label for="g-recaptcha-response" style="display:none;" hidden>Recaptcha response</label>
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
				{translate key="user.register"}
			</button>

			{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
			<p class="v-login-register">
			    Already have an account? <a href="{url page="login" source=$rolesProfileUrl}" class="login">{translate key="user.login"}</a>
            </p>
		</div>
	</form>
    </div><!-- v-login-form-container -->
    </div><!-- veridica-login-card -->
</div><!-- .page -->

<div class="pkp_structure_content">
	<div class="pkp_structure_main" role="main">

{include file="frontend/components/footer.tpl"}
