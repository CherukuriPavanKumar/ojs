{**
 * templates/frontend/pages/submissions.tpl
 * Veridica Flagship Author Guidelines & Online Submission Portal
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div class="page page_submissions veridica-inner-page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}

	<!-- Hero Header -->
	<div class="v-inner-hero">
		<div class="v-hero-badge"><i class="fas fa-feather-alt"></i> AUTHOR PORTAL</div>
		<h1 class="v-hero-title">Author Guidelines &amp; Submission Manual</h1>
		<p class="v-hero-subtitle">
			Everything you need to format, anonymize, and submit your research to Veridica. We welcome groundbreaking contributions in Computer Science &amp; AI, Biomedical Informatics, Quantum Technologies, and Societal Systems.
		</p>
	</div>

	<!-- Fast Action Gateway Card -->
	<div class="v-submission-action-banner">
		<div class="v-sub-act-text">
			<h3><i class="fas fa-rocket"></i> Ready to Submit Your Manuscript?</h3>
			<p>No author processing charges (100% Diamond Open Access). Average turnaround to initial editorial decision is 4.2 weeks.</p>
		</div>
		<div class="v-sub-act-btns">
			{if $isUserLoggedIn}
				<a href="{url page="submission"}" class="veridica-btn-primary v-btn-large">
					<i class="fas fa-cloud-upload-alt"></i> Start New Submission
				</a>
				<a href="{url page="submissions"}" class="veridica-btn-secondary v-btn-large">
					<i class="fas fa-tasks"></i> My Submissions
				</a>
			{else}
				<a href="{url page="submission"}" class="veridica-btn-primary v-btn-large">
					<i class="fas fa-cloud-upload-alt"></i> Submit Online
				</a>
				<a href="{url page="user" op="register"}" class="veridica-btn-secondary v-btn-large">
					<i class="fas fa-user-plus"></i> Register Author Account
				</a>
			{/if}
		</div>
	</div>

	<!-- 5-Phase Submission Lifecycle Infographic -->
	<div class="v-lifecycle-section">
		<h3 class="v-lifecycle-title"><i class="fas fa-road"></i> Peer Review &amp; Publication Lifecycle</h3>
		<div class="v-lifecycle-steps">
			<div class="v-step-item">
				<div class="v-step-num">01</div>
				<h4>Preparation</h4>
				<p>Anonymize manuscript for double-blind review, format citations to APA 7th, and prepare reproducible data.</p>
			</div>
			<div class="v-step-item">
				<div class="v-step-num">02</div>
				<h4>Submission</h4>
				<p>Upload manuscript via our online submission portal, link ORCID iD, and provide structured abstract.</p>
			</div>
			<div class="v-step-item">
				<div class="v-step-num">03</div>
				<h4>Double-Blind Review</h4>
				<p>Evaluation by 2+ independent domain experts. Transparent timeline with 4.2-week target.</p>
			</div>
			<div class="v-step-item">
				<div class="v-step-num">04</div>
				<h4>Revision</h4>
				<p>Authors address referee remarks. Handling editor renders final acceptance or revision decision.</p>
			</div>
			<div class="v-step-item">
				<div class="v-step-num">05</div>
				<h4>Production &amp; DOI</h4>
				<p>Typesetting, XML &amp; PDF galleys, Crossref DOI registration, and immediate global Diamond OA dissemination.</p>
			</div>
		</div>
	</div>

	<!-- Two-Column Guidelines & Requirements -->
	<div class="v-page-content-grid">
		
		<!-- Left Main Column: Detailed Guidelines -->
		<div class="v-page-main-col">

			<!-- Article Types -->
			<section class="v-content-card">
				<div class="v-content-card-header">
					<h2><i class="fas fa-file-alt"></i> Accepted Article Types</h2>
				</div>
				<div class="v-content-card-body">
					<div class="v-article-types-grid">
						<div class="v-type-box">
							<h4>Original Research Articles</h4>
							<p>Substantial empirical or theoretical contributions (6,000 &ndash; 10,000 words). Complete experimental validation, statistical methodology, and dataset availability required.</p>
						</div>
						<div class="v-type-box">
							<h4>Comprehensive Reviews</h4>
							<p>Systematic, high-level syntheses of emerging frontiers (8,000 &ndash; 14,000 words). Must include critical evaluation, taxonomies, and clear open research directions.</p>
						</div>
						<div class="v-type-box">
							<h4>Rapid Research Letters</h4>
							<p>High-urgency, compact breakthroughs (3,000 &ndash; 4,500 words). Accelerated editorial track with initial decision targeted within 2.5 weeks.</p>
						</div>
						<div class="v-type-box">
							<h4>Software, Datasets &amp; Benchmarks</h4>
							<p>Curated scientific datasets, machine learning benchmarks, or open-source scientific software with verifiable repository links (GitHub/Zenodo).</p>
						</div>
					</div>
				</div>
			</section>

			<!-- Manuscript Preparation & Structure -->
			<section class="v-content-card">
				<div class="v-content-card-header">
					<h2><i class="fas fa-pencil-ruler"></i> Manuscript Structure &amp; Formatting</h2>
				</div>
				<div class="v-content-card-body">
					<p>Manuscripts should be organized logically according to the following standard structure:</p>
					<ul class="v-styled-list">
						<li><strong>Title:</strong> Concise, informative, and devoid of non-standard abbreviations.</li>
						<li><strong>Structured Abstract:</strong> Maximum 250 words structured into four distinct headings: <em>Background</em>, <em>Methods</em>, <em>Results</em>, and <em>Conclusion</em>.</li>
						<li><strong>Keywords:</strong> 4 to 6 specific keywords separated by semicolons for indexing in Scopus and Crossref.</li>
						<li><strong>Introduction:</strong> Context, state-of-the-art literature gap, clear statement of scientific hypothesis, and primary contributions.</li>
						<li><strong>Methods &amp; Materials:</strong> Exhaustive description enabling exact replication of experiments, algorithms, or clinical procedures.</li>
						<li><strong>Results &amp; Discussion:</strong> Rigorous presentation with statistical significance metrics (p-values, confidence intervals), paired with thorough contextual interpretation.</li>
						<li><strong>Data Availability Statement:</strong> Mandatory section indicating where raw data, models, and code can be accessed.</li>
						<li><strong>References:</strong> Prepared in strict adherence to <strong>APA 7th Edition</strong>, including hyperlinked DOIs for every cited source.</li>
					</ul>
				</div>
			</section>

			<!-- Double Blind Anonymization Instructions -->
			<section class="v-content-card">
				<div class="v-content-card-header">
					<h2><i class="fas fa-user-secret"></i> Anonymization for Double-Blind Review</h2>
				</div>
				<div class="v-content-card-body">
					<p>
						To preserve the objectivity of peer review, author identities must be thoroughly concealed from the uploaded manuscript file:
					</p>
					<ul class="v-styled-list">
						<li>Remove all author names, institutional affiliations, and departmental addresses from the title page.</li>
						<li>Omit self-identifying references in the body text (e.g., replace "In our previous study (Smith et al., 2024)" with "In a previous study (Smith et al., 2024)").</li>
						<li>Remove author acknowledgments, grant reference numbers, and funding statements from the main document (these will be added back upon final acceptance).</li>
						<li>Strip personal metadata from file properties before upload (File &rarr; Properties &rarr; Remove Personal Info).</li>
					</ul>
				</div>
			</section>

			{if $currentContext->getLocalizedData('authorGuidelines')}
				<section class="v-content-card">
					<div class="v-content-card-header">
						<h2><i class="fas fa-book"></i> Additional Journal Guidelines</h2>
					</div>
					<div class="v-content-card-body">
						{$currentContext->getLocalizedData('authorGuidelines')}
					</div>
				</section>
			{/if}

		</div><!-- .v-page-main-col -->

		<!-- Right Column: Pre-submission Checklist & Template Downloads -->
		<aside class="v-page-sidebar-col">
			
			<!-- Template Downloads -->
			<div class="v-side-info-card">
				<h4 class="v-side-title"><i class="fas fa-file-download"></i> Manuscript Templates</h4>
				<p>Use our official templates to ensure compliance with typesetting specifications:</p>
				<div class="v-template-btn-group">
					<a href="#" class="v-tpl-btn" onclick="alert('Downloading Veridica Microsoft Word Template (.docx)'); return false;">
						<i class="fas fa-file-word"></i> Microsoft Word Template (.docx)
					</a>
					<a href="#" class="v-tpl-btn" onclick="alert('Opening Veridica LaTeX Template on Overleaf'); return false;">
						<i class="fas fa-file-code"></i> LaTeX / Overleaf Starter Pack
					</a>
					<a href="#" class="v-tpl-btn" onclick="alert('Downloading Veridica EndNote / Zotero Citation Style (.ens / .csl)'); return false;">
						<i class="fas fa-quote-right"></i> Zotero / CSL Citation Style
					</a>
				</div>
			</div>

			<!-- Mandatory Checklist -->
			<div class="v-side-info-card v-side-checklist-card">
				<h4 class="v-side-title"><i class="fas fa-tasks"></i> Pre-submission Checklist</h4>
				<ul class="v-side-checklist">
					<li><i class="far fa-check-square"></i> The manuscript represents original, unpublished work not under consideration elsewhere.</li>
					<li><i class="far fa-check-square"></i> Document file format is OpenOffice, Microsoft Word, or LaTeX PDF.</li>
					<li><i class="far fa-check-square"></i> All author identifying details have been removed for double-blind review.</li>
					<li><i class="far fa-check-square"></i> All figures are high-resolution (300+ DPI TIFF, EPS, or vector SVG).</li>
					<li><i class="far fa-check-square"></i> DOIs are provided for all cited references where available.</li>
					<li><i class="far fa-check-square"></i> A mandatory Data Availability statement is included.</li>
					<li><i class="far fa-check-square"></i> All co-authors have reviewed and approved the submitted version.</li>
				</ul>
			</div>

			<!-- Diamond Open Access Notice -->
			<div class="v-side-info-card v-side-oa-card">
				<h4 class="v-side-title"><i class="fas fa-hand-holding-heart"></i> Diamond Open Access</h4>
				<p>Remember: You will <strong>never be charged</strong> any publication fee. All research is freely accessible to all readers globally under Creative Commons CC BY 4.0.</p>
			</div>

		</aside>

	</div><!-- .v-page-content-grid -->

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
