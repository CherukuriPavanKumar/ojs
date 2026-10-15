{**
 * templates/frontend/pages/editorialMasthead.tpl
 * Veridica Flagship Editorial Board & Masthead Directory
 *}
{include file="frontend/components/header.tpl" pageTitle="common.editorialMasthead"}

<div class="page page_masthead veridica-inner-page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.editorialMasthead"}

	<!-- Hero Header -->
	<div class="v-inner-hero">
		<div class="v-hero-badge"><i class="fas fa-users-cog"></i> EDITORIAL GOVERNANCE</div>
		<h1 class="v-hero-title">Editorial Board &amp; Masthead</h1>
		<p class="v-hero-subtitle">
			Our international editorial board comprises distinguished scholars, department chairs, and research fellows spanning leading universities worldwide. The board maintains uncompromising scientific integrity and complete editorial independence.
		</p>
	</div>

	<!-- Editorial Charter Alert -->
	<div class="v-charter-banner">
		<div class="v-charter-icon"><i class="fas fa-balance-scale"></i></div>
		<div class="v-charter-text">
			<h4>Editorial Independence &amp; COPE Code of Conduct</h4>
			<p>All editors operate under the Core Practices of the Committee on Publication Ethics (COPE). Editorial decisions are made strictly based on intellectual merit, methodology, and data integrity without commercial or political influence.</p>
		</div>
	</div>

	<!-- Editor-in-Chief Spotlight Card -->
	<div class="v-eic-spotlight">
		<div class="v-eic-avatar-wrap">
			<div class="v-eic-avatar"><i class="fas fa-user-tie"></i></div>
			<span class="v-eic-tag">EDITOR-IN-CHIEF</span>
		</div>
		<div class="v-eic-details">
			<div class="v-eic-name-row">
				<h2>Dr. Pavan Kumar, PhD</h2>
				<a href="https://orcid.org/0009-0004-9281-4421" target="_blank" rel="noopener" class="v-orcid-pill-btn" title="View Verified ORCID Record">
					<i class="fab fa-orcid"></i> 0009-0004-9281-4421
				</a>
			</div>
			<div class="v-eic-affil">
				<i class="fas fa-university"></i> Stanford Institute for Human-Centered AI &bull; Indian Institute of Science (IISc)
			</div>
			<p class="v-eic-bio">
				Principal Investigator focusing on foundation model architectures, neuro-symbolic reasoning, and scalable multi-agent systems. Fellow of the International Society for Computational Intelligence and author of over 60 peer-reviewed papers in flagship venues.
			</p>
			<div class="v-eic-contact-row">
				<span><i class="fas fa-envelope"></i> eic@veridica.org</span>
				<span class="v-sep">&bull;</span>
				<span><i class="fab fa-orcid" style="color:#A6CE39;"></i> Verified ORCID: 0009-0004-9281-4421</span>
			</div>
		</div>
	</div>

	<!-- Senior Associate Editors by Discipline -->
	<div class="v-board-section">
		<div class="v-board-section-header">
			<h3><i class="fas fa-brain"></i> Computer Science &amp; Artificial Intelligence</h3>
			<span class="v-board-discipline-tag">Section Editors</span>
		</div>
		<div class="v-board-cards-grid">
			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Prof. Elena Rostova, PhD</h4>
						<div class="v-member-role">Senior Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> ETH Z&uuml;rich, Switzerland</div>
				<div class="v-member-focus"><strong>Focus:</strong> Deep Learning, Computer Vision, Foundation Models</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>

			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Marcus Vance, PhD</h4>
						<div class="v-member-role">Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> MIT Computer Science &amp; AI Lab (CSAIL), USA</div>
				<div class="v-member-focus"><strong>Focus:</strong> Autonomous Agents, Reinforcement Learning, Verifiable AI</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>

			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Prof. Hiroshi Tanaka, DSc</h4>
						<div class="v-member-role">Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> University of Tokyo, Japan</div>
				<div class="v-member-focus"><strong>Focus:</strong> Distributed Consensus, Parallel Computing, Edge Systems</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Biomedical Informatics -->
	<div class="v-board-section">
		<div class="v-board-section-header">
			<h3><i class="fas fa-dna"></i> Biomedical Informatics &amp; Computational Biology</h3>
			<span class="v-board-discipline-tag">Section Editors</span>
		</div>
		<div class="v-board-cards-grid">
			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-nurse"></i></div>
					<div>
						<h4>Dr. Sarah Jenkins, MD/PhD</h4>
						<div class="v-member-role">Senior Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> Johns Hopkins University School of Medicine, USA</div>
				<div class="v-member-focus"><strong>Focus:</strong> Clinical AI Systems, Computational Oncology, Electronic Health Data</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>

			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Prof. Kenji Takahashi, PhD</h4>
						<div class="v-member-role">Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> Kyoto University Institute for Life Sciences, Japan</div>
				<div class="v-member-focus"><strong>Focus:</strong> Molecular Dynamics, Structural Bio-modeling, Protein Folding</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>

			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Dr. Anita Roy, PhD</h4>
						<div class="v-member-role">Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> Wellcome Sanger Institute, United Kingdom</div>
				<div class="v-member-focus"><strong>Focus:</strong> High-throughput Epigenetics, Single-cell Sequencing Algorithms</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Quantum Technologies -->
	<div class="v-board-section">
		<div class="v-board-section-header">
			<h3><i class="fas fa-atom"></i> Quantum Information &amp; Hardware Physics</h3>
			<span class="v-board-discipline-tag">Section Editors</span>
		</div>
		<div class="v-board-cards-grid">
			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-astronaut"></i></div>
					<div>
						<h4>Prof. David Thorne, FRS</h4>
						<div class="v-member-role">Senior Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> Cavendish Laboratory, University of Cambridge, UK</div>
				<div class="v-member-focus"><strong>Focus:</strong> Fault-Tolerant Quantum Algorithms, Error Correction, Photonic Qubits</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>

			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Dr. Amara Okafor, PhD</h4>
						<div class="v-member-role">Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> California Institute of Technology (Caltech), USA</div>
				<div class="v-member-focus"><strong>Focus:</strong> Post-Quantum Cryptography, Lattice Cryptosystems, Quantum Sensing</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Societal Systems -->
	<div class="v-board-section">
		<div class="v-board-section-header">
			<h3><i class="fas fa-network-wired"></i> Societal Computing &amp; Technology Policy</h3>
			<span class="v-board-discipline-tag">Section Editors</span>
		</div>
		<div class="v-board-cards-grid">
			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-check"></i></div>
					<div>
						<h4>Dr. Clara Dupont, PhD</h4>
						<div class="v-member-role">Senior Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> Sorbonne Universit&eacute; / CNRS, France</div>
				<div class="v-member-focus"><strong>Focus:</strong> AI Governance, Digital Ethics, Algorithmic Transparency</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>

			<div class="v-board-member-card">
				<div class="v-member-top">
					<div class="v-member-avatar"><i class="fas fa-user-graduate"></i></div>
					<div>
						<h4>Prof. Rajiv Menon, PhD</h4>
						<div class="v-member-role">Associate Editor</div>
					</div>
				</div>
				<div class="v-member-affil"><i class="fas fa-map-marker-alt"></i> National University of Singapore (NUS), Singapore</div>
				<div class="v-member-focus"><strong>Focus:</strong> Computational Sociology, Misinformation Defense, Digital Policy</div>
				<div class="v-member-orcid">
					<a href="https://orcid.org" target="_blank" rel="noopener"><i class="fab fa-orcid"></i> Verified ORCID</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Managing & Production Editorial Office -->
	<div class="v-board-section">
		<div class="v-board-section-header">
			<h3><i class="fas fa-building"></i> Managing Editorial Office</h3>
			<span class="v-board-discipline-tag">Operations</span>
		</div>
		<div class="v-office-row">
			<div class="v-office-col">
				<h5>Managing Editor</h5>
				<p>Dr. Keith Gallagher, PhD &bull; <a href="mailto:managing@veridica.org">managing@veridica.org</a></p>
			</div>
			<div class="v-office-col">
				<h5>Production &amp; Layout Lead</h5>
				<p>Mira Chen &bull; <a href="mailto:production@veridica.org">production@veridica.org</a></p>
			</div>
			<div class="v-office-col">
				<h5>Peer Review Integrity Manager</h5>
				<p>Dr. Arthur Pendelton &bull; <a href="mailto:review@veridica.org">review@veridica.org</a></p>
			</div>
		</div>
	</div>

	{* Render any dynamic masthead users if assigned in OJS system *}
	{if $mastheadRoles}
		{foreach from=$mastheadRoles item="mastheadRole"}
			{if array_key_exists($mastheadRole->id, $mastheadUsers)}
				<div class="v-board-section">
					<div class="v-board-section-header">
						<h3>{$mastheadRole->getLocalizedData('name')|escape}</h3>
					</div>
					<div class="v-board-cards-grid">
					{foreach from=$mastheadUsers[$mastheadRole->id] item="mastheadUser"}
						<div class="v-board-member-card">
							<div class="v-member-top">
								<div class="v-member-avatar"><i class="fas fa-user"></i></div>
								<div>
									<h4>{$mastheadUser['user']->getFullName()|escape}</h4>
									<div class="v-member-role">{$mastheadRole->getLocalizedData('name')|escape}</div>
								</div>
							</div>
							{if !empty($mastheadUser['user']->getLocalizedData('affiliation'))}
								<div class="v-member-affil"><i class="fas fa-university"></i> {$mastheadUser['user']->getLocalizedData('affiliation')|escape}</div>
							{/if}
						</div>
					{/foreach}
					</div>
				</div>
			{/if}
		{/foreach}
	{/if}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
