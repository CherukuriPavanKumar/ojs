{**
 * templates/frontend/pages/privacy.tpl
 * Veridica Comprehensive Academic Privacy & Data Governance Statement
 *}
{include file="frontend/components/header.tpl" pageTitle="manager.setup.privacyStatement"}

<div class="page page_privacy veridica-inner-page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="manager.setup.privacyStatement"}

	<!-- Hero Header -->
	<div class="v-inner-hero">
		<div class="v-hero-badge"><i class="fas fa-user-shield"></i> DATA GOVERNANCE &amp; PRIVACY</div>
		<h1 class="v-hero-title">Privacy Policy &amp; Data Protection Statement</h1>
		<p class="v-hero-subtitle">
			Veridica Publishing Group operates in full compliance with the European Union General Data Protection Regulation (GDPR), the Digital Personal Data Protection (DPDP) Act 2023, and international research integrity frameworks.
		</p>
	</div>

	<!-- Core Privacy Highlights Banner -->
	<div class="v-privacy-banner">
		<div class="v-pv-point">
			<i class="fas fa-check-circle"></i>
			<span><strong>Zero Commercial Sale:</strong> We never sell, rent, or trade researcher data to commercial advertisers.</span>
		</div>
		<div class="v-pv-point">
			<i class="fas fa-lock"></i>
			<span><strong>Strict Manuscript Secrecy:</strong> Unpublished manuscripts are treated as confidential intellectual property.</span>
		</div>
		<div class="v-pv-point">
			<i class="fas fa-cookie-bite"></i>
			<span><strong>No Invasive Tracking:</strong> Essential session cookies only; zero 3rd-party ad pixels.</span>
		</div>
	</div>

	<!-- Main Policy Grid -->
	<div class="v-policy-grid">

		<!-- Article 1 -->
		<section class="v-policy-card">
			<div class="v-policy-card-header">
				<span class="v-sec-num">01</span>
				<h3>Scope &amp; Data Controller</h3>
			</div>
			<div class="v-policy-card-body">
				<p>
					This Privacy Statement applies to all services, manuscript submission workflows, reviewer evaluations, and reader access channels provided by <strong>Veridica: Journal of Multidisciplinary Research</strong>. The data controller responsible for the processing of your personal information is Veridica Publishing Group.
				</p>
			</div>
		</section>

		<!-- Article 2 -->
		<section class="v-policy-card">
			<div class="v-policy-card-header">
				<span class="v-sec-num">02</span>
				<h3>Personal Data Collected &amp; Purpose</h3>
			</div>
			<div class="v-policy-card-body">
				<p>We process only data strictly essential for scholarly communication and journal operations:</p>
				<ul class="v-styled-list">
					<li><strong>Authors &amp; Co-authors:</strong> Full legal name, institutional email address, institutional affiliation, ORCID iD, country of origin, biographical statement, and submitted research manuscripts.</li>
					<li><strong>Peer Reviewers:</strong> Academic qualifications, research specializations, institutional email, review timelines, and confidential peer review assessments.</li>
					<li><strong>Readers:</strong> Technical log data (IP address, browser user-agent) collected solely for cybersecurity monitoring, rate-limiting, and aggregate usage statistics conforming to the COUNTER code of practice.</li>
				</ul>
			</div>
		</section>

		<!-- Article 3 -->
		<section class="v-policy-card">
			<div class="v-policy-card-header">
				<span class="v-sec-num">03</span>
				<h3>Protection of Unpublished Manuscripts</h3>
			</div>
			<div class="v-policy-card-body">
				<p>
					Manuscripts under peer review are privileged communications. Veridica guarantees:
				</p>
				<ul class="v-styled-list">
					<li>Unpublished research files are accessible only to the designated handling editors and assigned reviewers.</li>
					<li>Files are strictly prohibited from being ingested by third-party large language models (LLMs) or commercial data miners.</li>
					<li>Reviewers must delete downloaded draft copies upon completing their evaluation.</li>
				</ul>
			</div>
		</section>

		<!-- Article 4 -->
		<section class="v-policy-card">
			<div class="v-policy-card-header">
				<span class="v-sec-num">04</span>
				<h3>Double-Blind Peer Review Anonymization</h3>
			</div>
			<div class="v-policy-card-body">
				<p>
					To guarantee unbiased scientific assessment, author identities and affiliations are segregated from reviewers until a final decision is reached. Reviewer identities are held in permanent confidence and are never disclosed publicly or to the authors, upholding the highest standards of the Committee on Publication Ethics (COPE).
				</p>
			</div>
		</section>

		<!-- Article 5 -->
		<section class="v-policy-card">
			<div class="v-policy-card-header">
				<span class="v-sec-num">05</span>
				<h3>Scholarly Indexing &amp; Metadata Dissemination</h3>
			</div>
			<div class="v-policy-card-body">
				<p>
					Upon formal acceptance and publication, article bibliographic metadata (article title, author names, affiliations, ORCID iDs, abstract, DOI) is publicly deposited into scientific registry databases including Crossref, Scopus, DOAJ, and national digital repositories. This dissemination is lawful, essential for scientific citation tracking, and authorized under our CC BY 4.0 license terms.
				</p>
			</div>
		</section>

		<!-- Article 6 -->
		<section class="v-policy-card">
			<div class="v-policy-card-header">
				<span class="v-sec-num">06</span>
				<h3>Your Rights &amp; Data Subject Requests</h3>
			</div>
			<div class="v-policy-card-body">
				<p>Under GDPR Articles 15–22 and the DPDP Act 2023, you hold the following uncompromised rights:</p>
				<ul class="v-styled-list">
					<li><strong>Right of Access &amp; Portability:</strong> Request an export of all personal data held in your user profile.</li>
					<li><strong>Right of Rectification:</strong> Update inaccurate contact details or affiliations via your user dashboard.</li>
					<li><strong>Right to Erasure:</strong> Request deletion of account credentials (note: published articles form a permanent part of the scientific record and cannot be altered or removed, in accordance with COPE Retraction Guidelines).</li>
				</ul>
				<div class="v-dpo-contact-box">
					<i class="fas fa-envelope-open-text"></i>
					<div>
						<strong>Data Protection Officer (DPO) Contact:</strong><br>
						Email: <a href="mailto:privacy@veridica.org">privacy@veridica.org</a> &bull; Response turnaround: Within 14 business days.
					</div>
				</div>
			</div>
		</section>

	</div><!-- .v-policy-grid -->

	{if $privacyStatement}
		<div class="v-admin-privacy-content" style="margin-top: 32px;">
			<h4 style="margin-bottom: 12px; color: var(--v-navy);">Additional Context Terms:</h4>
			{$privacyStatement}
		</div>
	{/if}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
