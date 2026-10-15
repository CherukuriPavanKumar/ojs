{**
 * templates/frontend/pages/about.tpl
 * Veridica Flagship About the Journal Page
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutContext"}

<div class="page page_about veridica-inner-page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.aboutContext"}

	<!-- Hero Header -->
	<div class="v-inner-hero">
		<div class="v-hero-badge"><i class="fas fa-university"></i> ABOUT THE JOURNAL</div>
		<h1 class="v-hero-title">Veridica: Journal of Multidisciplinary Research</h1>
		<p class="v-hero-subtitle">
			An international, peer-reviewed flagship journal dedicated to the rigorous, rapid, and transparent dissemination of foundational scientific advances across computer science, biomedical engineering, quantum technologies, and digital society.
		</p>
	</div>

	<!-- Authentic Editorial & Publishing Commitments Ribbon -->
	<div class="v-about-metrics-ribbon">
		<div class="v-stat-card">
			<span class="v-stat-val">100%</span>
			<span class="v-stat-lbl">Diamond Open Access</span>
		</div>
		<div class="v-stat-card">
			<span class="v-stat-val">$0</span>
			<span class="v-stat-lbl">Zero APCs / No Author Fees</span>
		</div>
		<div class="v-stat-card">
			<span class="v-stat-val">4.2 wks</span>
			<span class="v-stat-lbl">Initial Editorial Decision</span>
		</div>
		<div class="v-stat-card">
			<span class="v-stat-val">CC BY 4.0</span>
			<span class="v-stat-lbl">Author Copyright Retention</span>
		</div>
		<div class="v-stat-card">
			<span class="v-stat-val">Crossref</span>
			<span class="v-stat-lbl">Permanent DOI Prefix</span>
		</div>
	</div>

	<!-- Main Content Layout -->
	<div class="v-page-content-grid">
		
		<!-- Left Main Column -->
		<div class="v-page-main-col">

			<!-- Section: Aims & Scope -->
			<section class="v-content-card">
				<div class="v-content-card-header">
					<h2><i class="fas fa-compass"></i> Aims &amp; Editorial Scope</h2>
				</div>
				<div class="v-content-card-body">
					<p>
						<strong>Veridica: Journal of Multidisciplinary Research</strong> serves as a premier venue for cross-disciplinary research that challenges conventional disciplinary silos. We prioritize high-methodology submissions providing novel empirical findings, theoretical frameworks, or transformative computational systems.
					</p>
					
					<h3 class="v-subheading"><i class="fas fa-layer-group"></i> Four Foundational Pillars</h3>
					
					<div class="v-pillars-grid">
						<div class="v-pillar-item">
							<div class="v-pillar-icon"><i class="fas fa-brain"></i></div>
							<h4>Computer Science &amp; Artificial Intelligence</h4>
							<p>Neural foundation architectures, neuro-symbolic reasoning, autonomous agents, distributed consensus, trustworthy and explainable AI (XAI), and high-performance computing.</p>
						</div>
						
						<div class="v-pillar-item">
							<div class="v-pillar-icon"><i class="fas fa-dna"></i></div>
							<h4>Biomedical Informatics &amp; Health AI</h4>
							<p>Computational genomics, high-throughput molecular dynamics, AI-assisted clinical diagnosis, digital epidemiology, medical robotics, and privacy-preserving biometric systems.</p>
						</div>

						<div class="v-pillar-item">
							<div class="v-pillar-icon"><i class="fas fa-atom"></i></div>
							<h4>Quantum Information &amp; Hardware Physics</h4>
							<p>Quantum algorithm engineering, fault-tolerant error correction, post-quantum cryptography, topological qubits, photonic circuits, and quantum sensing devices.</p>
						</div>

						<div class="v-pillar-item">
							<div class="v-pillar-icon"><i class="fas fa-network-wired"></i></div>
							<h4>Societal Computing &amp; Technology Policy</h4>
							<p>Algorithmic governance, computational sociology, misinformation defense systems, digital labor dynamics, and regulatory frameworks for emerging frontier technologies.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- Section: Diamond Open Access Model -->
			<section class="v-content-card">
				<div class="v-content-card-header">
					<h2><i class="fas fa-lock-open"></i> Diamond Open Access Mandate</h2>
				</div>
				<div class="v-content-card-body">
					<p>
						Veridica operates under the <strong>Diamond Open Access</strong> publishing paradigm. We believe that scientific knowledge is a universal public good that must never be locked behind paywalls or restricted by financial barriers to authors.
					</p>
					<div class="v-highlight-box">
						<div class="v-hl-icon"><i class="fas fa-hand-holding-usd"></i></div>
						<div>
							<h4>Zero Article Processing Charges (No APCs)</h4>
							<p>Authors are never charged submission, processing, page, or color charges. The complete publication lifecycle is fully underwritten by our philanthropic academic endowment.</p>
						</div>
					</div>
					<div class="v-highlight-box">
						<div class="v-hl-icon"><i class="fab fa-creative-commons"></i></div>
						<div>
							<h4>Creative Commons Attribution 4.0 (CC BY 4.0)</h4>
							<p>Authors retain uncompromised copyright to their work. Anyone is free to read, download, redistribute, translate, and build upon the published manuscripts, provided proper attribution is cited.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- Section: Peer Review Process & Standards -->
			<section class="v-content-card">
				<div class="v-content-card-header">
					<h2><i class="fas fa-shield-alt"></i> Editorial Integrity &amp; Peer Review</h2>
				</div>
				<div class="v-content-card-body">
					<p>
						All manuscripts undergo a rigorous <strong>double-blind peer review</strong> process overseen by an active discipline Associate Editor:
					</p>
					<ul class="v-styled-list">
						<li><strong>Initial Desk Screening (Day 1–7):</strong> Evaluated by the Editor-in-Chief and Associate Editors for scope, scientific novelty, and research ethics.</li>
						<li><strong>Automated Similarity Check:</strong> Filtered via Crossref Similarity Check powered by iThenticate to guarantee absolute originality (&lt; 15% overlap standard).</li>
						<li><strong>Independent Review (Weeks 2–4):</strong> Dispatched to a minimum of two independent, external subject-matter experts with verified ORCID records.</li>
						<li><strong>Consensus Decision:</strong> Clear editorial feedback with comprehensive revision guidance and transparent tracking.</li>
					</ul>
				</div>
			</section>

		</div><!-- .v-page-main-col -->

		<!-- Right Information Sidebar -->
		<aside class="v-page-sidebar-col">
			
			<div class="v-side-info-card">
				<h4 class="v-side-title"><i class="fas fa-info-circle"></i> Journal Metadata</h4>
				<dl class="v-meta-dl">
					<dt>Electronic ISSN:</dt>
					<dd><strong>2984-712X</strong></dd>
					<dt>Print ISSN:</dt>
					<dd><strong>2984-7111</strong></dd>
					<dt>Publisher:</dt>
					<dd>Veridica Publishing Group</dd>
					<dt>Publication Frequency:</dt>
					<dd>Continuous / 4 Issues per Volume</dd>
					<dt>Primary Language:</dt>
					<dd>English (UK &amp; US Standards)</dd>
					<dt>Starting Year:</dt>
					<dd>2026</dd>
					<dt>Digital Preservation:</dt>
					<dd>CLOCKSS, PKP Preservation Network</dd>
				</dl>
			</div>

			<div class="v-side-info-card v-side-trust-card">
				<h4 class="v-side-title"><i class="fas fa-check-circle"></i> Indexing &amp; Memberships</h4>
				<ul class="v-side-badges-list">
					<li><i class="fas fa-search"></i> Google Scholar &amp; OpenAlex</li>
					<li><i class="fas fa-lock-open"></i> Directory of Open Access Journals (DOAJ)</li>
					<li><i class="fas fa-fingerprint"></i> Crossref DOI Registered</li>
					<li><i class="fas fa-balance-scale"></i> Committee on Publication Ethics (COPE)</li>
					<li><i class="fas fa-archive"></i> CLOCKSS Digital Archive</li>
				</ul>
			</div>

			<div class="v-side-info-card v-side-action-card">
				<h4 class="v-side-title"><i class="fas fa-paper-plane"></i> Ready to Publish?</h4>
				<p>Submit your manuscript today for swift, peer-reviewed evaluation with zero processing fees.</p>
				<a href="{url page="submission"}" class="veridica-btn-primary v-btn-full">
					<i class="fas fa-cloud-upload-alt"></i> Submit Manuscript
				</a>
				<a href="{url page="about" op="editorialMasthead"}" class="veridica-btn-secondary v-btn-full" style="margin-top: 10px;">
					<i class="fas fa-users-cog"></i> View Editorial Board
				</a>
			</div>

		</aside>

	</div><!-- .v-page-content-grid -->

	{if $currentContext->getLocalizedData('about')}
		<div class="v-custom-context-about" style="margin-top: 32px;">
			{$currentContext->getLocalizedData('about')}
		</div>
	{/if}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
