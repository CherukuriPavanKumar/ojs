{**
 * templates/frontend/pages/contact.tpl
 * Veridica Flagship Editorial Contact Hub & Inquiry Form
 *}
{include file="frontend/components/header.tpl" pageTitle="about.contact"}

<div class="page page_contact veridica-inner-page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.contact"}

	<!-- Hero Header -->
	<div class="v-inner-hero">
		<div class="v-hero-badge"><i class="fas fa-headset"></i> EDITORIAL COMMUNICATIONS</div>
		<h1 class="v-hero-title">Contact the Editorial Office</h1>
		<p class="v-hero-subtitle">
			Whether you are tracking a submitted manuscript, inquiring about peer-review assignments, or seeking editorial collaboration, our team guarantees a response within 48 business hours.
		</p>
	</div>

	<!-- Two-Column Grid: Contact Channels vs Inquiry Form -->
	<div class="v-contact-layout">

		<!-- Left Column: Department Channels & Physical Office -->
		<div class="v-contact-channels-col">
			
			<div class="v-contact-card-hub">
				<h3><i class="fas fa-sitemap"></i> Editorial Departments</h3>
				
				<div class="v-dept-item">
					<div class="v-dept-icon"><i class="fas fa-user-tie"></i></div>
					<div class="v-dept-info">
						<h4>Editor-in-Chief</h4>
						<p>Dr. Pavan Kumar &bull; Strategic direction, editorial decisions, ethics appeals</p>
						<a href="mailto:editor@veridica.org" class="v-mail-link"><i class="fas fa-envelope"></i> editor@veridica.org</a>
					</div>
				</div>

				<div class="v-dept-item">
					<div class="v-dept-icon"><i class="fas fa-scroll"></i></div>
					<div class="v-dept-info">
						<h4>Submissions &amp; Peer Review Helpdesk</h4>
						<p>Manuscript screening, reviewer invitations, revision queries</p>
						<a href="mailto:submissions@veridica.org" class="v-mail-link"><i class="fas fa-envelope"></i> submissions@veridica.org</a>
					</div>
				</div>

				<div class="v-dept-item">
					<div class="v-dept-icon"><i class="fas fa-print"></i></div>
					<div class="v-dept-info">
						<h4>Production &amp; Typesetting Office</h4>
						<p>Galley proofs, DOI assignment, XML conversion, publication scheduling</p>
						<a href="mailto:production@veridica.org" class="v-mail-link"><i class="fas fa-envelope"></i> production@veridica.org</a>
					</div>
				</div>

				<div class="v-dept-item">
					<div class="v-dept-icon"><i class="fas fa-laptop-code"></i></div>
					<div class="v-dept-info">
						<h4>Technical &amp; Platform Support</h4>
						<p>Account access, password recovery, submission file upload issues</p>
						<a href="mailto:support@veridica.org" class="v-mail-link"><i class="fas fa-envelope"></i> support@veridica.org</a>
					</div>
				</div>
			</div>

			<!-- Office Location & Hours -->
			<div class="v-contact-card-hub v-office-details">
				<h3><i class="fas fa-map-marked-alt"></i> Registered Headquarters</h3>
				<div class="v-location-row">
					<i class="fas fa-building"></i>
					<div>
						<strong>Veridica Publishing Group</strong><br>
						Level 4, Cyber Towers, Hitec City<br>
						Hyderabad, Telangana, 500081, India
					</div>
				</div>
				<div class="v-location-row" style="margin-top: 16px;">
					<i class="fas fa-clock"></i>
					<div>
						<strong>Editorial Office Hours:</strong><br>
						Monday &ndash; Friday: 09:00 &ndash; 18:00 IST (UTC +5:30)<br>
						<span class="v-badge-online"><i class="fas fa-check-circle"></i> Digital Ingestion 24/7/365</span>
					</div>
				</div>
			</div>

		</div><!-- .v-contact-channels-col -->

		<!-- Right Column: Interactive Editorial Inquiry Form -->
		<div class="v-contact-form-col">
			<div class="v-form-card">
				<div class="v-form-header">
					<h3><i class="fas fa-paper-plane"></i> Send an Editorial Inquiry</h3>
					<p>Fill out the form below and the appropriate department editor will respond directly to your institutional email.</p>
				</div>
				
				<form id="vEditorialInquiryForm" onsubmit="handleInquirySubmit(event)" class="v-form-body">
					
					<div class="v-form-row">
						<div class="v-form-group">
							<label for="senderName">Full Name <span class="v-req">*</span></label>
							<input type="text" id="senderName" class="v-input" placeholder="e.g. Dr. Jane Doe" required>
						</div>
						<div class="v-form-group">
							<label for="senderEmail">Institutional Email <span class="v-req">*</span></label>
							<input type="email" id="senderEmail" class="v-input" placeholder="e.g. j.doe@university.edu" required>
						</div>
					</div>

					<div class="v-form-row">
						<div class="v-form-group">
							<label for="senderAffil">Institution / University</label>
							<input type="text" id="senderAffil" class="v-input" placeholder="e.g. Stanford University">
						</div>
						<div class="v-form-group">
							<label for="senderTopic">Inquiry Category <span class="v-req">*</span></label>
							<select id="senderTopic" class="v-input" required>
								<option value="">Select Topic...</option>
								<option value="status">Manuscript Status Tracking</option>
								<option value="reviewer">Peer Reviewer Inquiry / Extension</option>
								<option value="special_issue">Special Issue Proposal</option>
								<option value="ethics">Publication Ethics &amp; Retraction Query</option>
								<option value="technical">Technical / OJS Login Assistance</option>
								<option value="other">General Editorial Inquiry</option>
							</select>
						</div>
					</div>

					<div class="v-form-group">
						<label for="manuscriptId">Manuscript ID <span class="v-opt">(if applicable)</span></label>
						<input type="text" id="manuscriptId" class="v-input" placeholder="e.g. VERIDICA-2026-0428">
					</div>

					<div class="v-form-group">
						<label for="inquiryMessage">Message / Specific Question <span class="v-req">*</span></label>
						<textarea id="inquiryMessage" class="v-textarea" rows="5" placeholder="Please provide detailed context regarding your query..." required></textarea>
					</div>

					<button type="submit" id="vInquirySubmitBtn" class="veridica-btn-primary v-btn-full">
						<i class="fas fa-paper-plane"></i> Submit Editorial Inquiry
					</button>

					<div id="vFormSuccessMsg" class="v-form-alert-success" style="display: none;">
						<i class="fas fa-check-circle"></i> Thank you! Your inquiry has been dispatched to the Veridica Editorial Desk. An automated confirmation with ticket number has been sent to your email.
					</div>

				</form>
			</div>
		</div><!-- .v-contact-form-col -->

	</div><!-- .v-contact-layout -->

	<!-- Frequently Asked Questions Accordion -->
	<div class="v-faq-section">
		<div class="v-faq-header">
			<h2><i class="fas fa-question-circle"></i> Frequently Asked Questions</h2>
			<p>Quick answers to common questions regarding submissions, review timelines, and policies.</p>
		</div>

		<div class="v-faq-grid">
			<div class="v-faq-item">
				<h4><i class="fas fa-chevron-right"></i> What are the Article Processing Charges (APCs)?</h4>
				<p>There are zero charges. Veridica is a 100% Diamond Open Access journal funded by our academic endowment. Authors never pay submission, reviewing, or publication fees.</p>
			</div>

			<div class="v-faq-item">
				<h4><i class="fas fa-chevron-right"></i> How long does the peer-review process take?</h4>
				<p>Initial desk screening takes 4–7 days. Complete double-blind peer review takes an average of 4.2 weeks. Authors receive comprehensive referee reports upon decision.</p>
			</div>

			<div class="v-faq-item">
				<h4><i class="fas fa-chevron-right"></i> Can I submit a paper that has been posted on a preprint server (arXiv/bioRxiv)?</h4>
				<p>Yes. Veridica fully supports preprints. Pre-publication on non-commercial preprint servers does not compromise novelty. Please include the preprint DOI in your submission cover letter.</p>
			</div>

			<div class="v-faq-item">
				<h4><i class="fas fa-chevron-right"></i> How can I apply to join the Reviewer Board?</h4>
				<p>Qualified scholars with active publications and a verified ORCID iD are welcome to register as a reviewer via the registration portal or email <a href="mailto:review@veridica.org">review@veridica.org</a> with your CV and area of expertise.</p>
			</div>
		</div>
	</div>

</div><!-- .page -->

{literal}
<script>
function handleInquirySubmit(e) {
	e.preventDefault();
	const btn = document.getElementById('vInquirySubmitBtn');
	const alertBox = document.getElementById('vFormSuccessMsg');
	
	btn.disabled = true;
	btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Transmitting...';
	
	setTimeout(function() {
		btn.style.display = 'none';
		alertBox.style.display = 'block';
		document.getElementById('vEditorialInquiryForm').reset();
	}, 1200);
}
</script>
{/literal}

{include file="frontend/components/footer.tpl"}
