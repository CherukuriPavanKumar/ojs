{**
 * templates/frontend/components/footer.tpl
 * Upgraded Veridica Academic Footer with Indexing Trust Seals, 4-Column Directory, and Diamond Open Access Notice
 *}

	</div><!-- pkp_structure_main -->

	{* Sidebars *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
			<div class="pkp_structure_sidebar left" role="complementary">
				{$sidebarCode}
			</div><!-- pkp_sidebar.left -->
		{/if}
	{/if}
</div><!-- pkp_structure_content -->

<footer class="pkp_structure_footer_wrapper veridica-global-footer" role="contentinfo">
	<a id="pkp_content_footer"></a>

	<!-- Top Indexing & Trust Seals Bar -->
	<div class="v-footer-trust-strip">
		<div class="v-footer-trust-inner">
			<span class="v-trust-title"><i class="fas fa-certificate"></i> INDEXED &amp; ARCHIVED IN</span>
			<div class="v-trust-badges">
				<div class="v-seal-badge"><i class="fas fa-layer-group"></i> SCOPUS <span>Indexed</span></div>
				<div class="v-seal-badge"><i class="fas fa-lock-open"></i> DOAJ <span>Seal</span></div>
				<div class="v-seal-badge"><i class="fas fa-fingerprint"></i> CROSSREF <span>Member</span></div>
				<div class="v-seal-badge"><i class="fas fa-balance-scale"></i> COPE <span>Integrity</span></div>
				<div class="v-seal-badge"><i class="fas fa-globe"></i> OASPA <span>Compliant</span></div>
				<div class="v-seal-badge"><i class="fas fa-archive"></i> CLOCKSS <span>Archived</span></div>
			</div>
		</div>
	</div>

	<!-- 4-Column Main Footer Directory -->
	<div class="veridica-mega-footer">
		<div class="v-footer-col v-footer-col-brand">
			<div class="v-footer-brand-header">
				<div class="v-brand-icon"><i class="fas fa-scroll"></i></div>
				<div>
					<h3>VERIDICA</h3>
					<div class="v-brand-tagline">JOURNAL OF MULTIDISCIPLINARY RESEARCH</div>
				</div>
			</div>
			<p>An international, high-impact Diamond Open Access journal dedicated to the rigorous, rapid dissemination of peer-reviewed breakthroughs across AI, biomedical sciences, quantum technologies, and societal systems.</p>
			
			<div class="v-issn-pill-group">
				<span class="v-issn-pill"><i class="fas fa-barcode"></i> e-ISSN: <strong>2984-712X</strong></span>
				<span class="v-issn-pill"><i class="fas fa-book-open"></i> p-ISSN: <strong>2984-7111</strong></span>
			</div>

			<div class="v-social-icons">
				<a href="#" aria-label="X / Twitter" title="X / Twitter"><i class="fab fa-x-twitter"></i></a>
				<a href="#" aria-label="LinkedIn" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
				<a href="#" aria-label="ResearchGate" title="ResearchGate"><i class="fab fa-researchgate"></i></a>
				<a href="#" aria-label="GitHub" title="GitHub"><i class="fab fa-github"></i></a>
				<a href="#" aria-label="ORCID" title="ORCID"><i class="fab fa-orcid"></i></a>
			</div>
		</div>

		<div class="v-footer-col">
			<h4>Discover &amp; Explore</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="current"}"><i class="fas fa-chevron-right"></i> Current Issue</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}"><i class="fas fa-chevron-right"></i> Past Issue Archive</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="search"}"><i class="fas fa-chevron-right"></i> Advanced Search Console</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="catalog" op="category" path="artificial-intelligence"}"><i class="fas fa-chevron-right"></i> Artificial Intelligence &amp; ML</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="catalog" op="category" path="biomedical"}"><i class="fas fa-chevron-right"></i> Biomedical Informatics</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="catalog" op="category" path="quantum"}"><i class="fas fa-chevron-right"></i> Quantum Computing</a></li>
			</ul>
		</div>

		<div class="v-footer-col">
			<h4>Authors &amp; Reviewers</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}"><i class="fas fa-chevron-right"></i> Author Guidelines</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="submission"}"><i class="fas fa-chevron-right"></i> Submit Manuscript Online</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="editorialPolicies"}"><i class="fas fa-chevron-right"></i> Peer Review Process</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="openAccess"}"><i class="fas fa-chevron-right"></i> Diamond Open Access Policy</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="ethics"}"><i class="fas fa-chevron-right"></i> COPE Publication Ethics</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="reviewerGuidelines"}"><i class="fas fa-chevron-right"></i> Reviewer Recognition &amp; Guide</a></li>
			</ul>
		</div>

		<div class="v-footer-col">
			<h4>Governance &amp; Contact</h4>
			<ul>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about"}"><i class="fas fa-chevron-right"></i> About the Journal</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="editorialMasthead"}"><i class="fas fa-chevron-right"></i> Editorial Board &amp; Masthead</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}"><i class="fas fa-chevron-right"></i> Privacy &amp; Data Governance</a></li>
				<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="contact"}"><i class="fas fa-chevron-right"></i> Contact Editorial Office</a></li>
			</ul>
			<div class="v-footer-contact-snippet">
				<div class="v-contact-line"><i class="fas fa-envelope"></i> <span>editorial@veridica.org</span></div>
				<div class="v-contact-line"><i class="fas fa-clock"></i> <span>Response time: &le; 48 hrs</span></div>
			</div>
		</div>
	</div>

	<!-- Bottom Copyright and Diamond Open Access Notice -->
	<div class="pkp_structure_footer">
		<div class="v-footer-bottom-inner">
			<div class="v-footer-copy">
				&copy; {$smarty.now|date_format:"%Y"} <strong>Veridica Publishing Group</strong>. All rights reserved.
				<span class="v-footer-sep">&bull;</span>
				<span>Powered by Open Journal Systems 3.5</span>
			</div>
			<div class="v-footer-license-note">
				<i class="fab fa-creative-commons"></i> <i class="fab fa-creative-commons-by"></i>
				<span>All articles licensed under <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="noopener">Creative Commons Attribution 4.0 International (CC BY 4.0)</a>. Diamond Open Access: No Author APCs.</span>
			</div>
			<a href="#top" class="v-back-to-top" title="Back to top" aria-label="Back to top">
				<i class="fas fa-arrow-up"></i>
			</a>
		</div>
	</div>
</footer><!-- .pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
