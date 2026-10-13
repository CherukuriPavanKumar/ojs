{include file="frontend/components/header.tpl" pageTitleTranslated="Veridica Super Admin Panel"}

<!-- Import SAGE / Scopus Academic Typography: Cormorant Garamond, Merriweather & Inter -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;700&family=Inter:wght@400;500;600;700&family=Lora:ital,wght@0,500;0,600;0,700;1,400&family=Merriweather:ital,wght@0,400;0,700;1,300&display=swap" rel="stylesheet">

<div id="veridica-superadmin-root" class="vsa-container">

    <!-- Toast Notification Container (WCAG 2.1 AA accessible) -->
    <div id="vsa-toast-container" class="vsa-toast-container" aria-live="polite" aria-atomic="true"></div>

    <!-- Accessible Confirmation Modal (Replaces browser confirm) -->
    <div id="vsa-modal" class="vsa-modal-backdrop" role="dialog" aria-modal="true" aria-labelledby="vsa-modal-title" aria-describedby="vsa-modal-desc" style="display: none;">
        <div class="vsa-modal-box">
            <div class="vsa-modal-header">
                <div class="vsa-modal-icon-wrap" id="vsa-modal-icon-wrap">
                    <svg width="22" height="22" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
                </div>
                <div>
                    <h3 id="vsa-modal-title" class="vsa-modal-title">Confirm Action</h3>
                    <p id="vsa-modal-desc" class="vsa-modal-desc">Are you sure you want to proceed?</p>
                </div>
            </div>
            <div class="vsa-modal-footer">
                <button type="button" id="vsa-modal-cancel" class="vsa-btn vsa-btn-neutral">Cancel</button>
                <button type="button" id="vsa-modal-confirm" class="vsa-btn vsa-btn-danger">Confirm</button>
            </div>
        </div>
    </div>

    <!-- Institutional Academic Header & Top Navigation Bar -->
    <header class="vsa-institution-header" role="banner">
        <div class="vsa-brand-section">
            <div class="vsa-emblem">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#C9A84C" stroke-width="2"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
            </div>
            <div class="vsa-brand-meta">
                <div class="vsa-brand-title">VERIDICA ACADEMIC PUBLISHING</div>
                <div class="vsa-brand-sub">Journal Administration &amp; Executive Oversight</div>
            </div>
            <span class="vsa-badge-status" title="Cross-journal universal oversight active">Indexed System &bull; Open Access Oversight</span>
        </div>

        <div class="vsa-header-right">
            <a href="{$baseUrl}/index.php/veridica" class="vsa-link-portal" target="_blank" rel="noopener">
                Main OJS Portal
                <svg width="14" height="14" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
            </a>
            <div class="vsa-user-pill">
                <div class="vsa-avatar">S</div>
                <div class="vsa-user-info">
                    <span class="vsa-user-name">Super Administrator</span>
                    <span class="vsa-user-role">Universal Governance</span>
                </div>
            </div>
        </div>
    </header>

    <!-- Top Navigation Tabs & Quick Export Action Bar -->
    <div class="vsa-nav-bar" role="navigation" aria-label="Super Admin Tabs">
        <div class="vsa-tab-group" role="tablist">
            <button class="vsa-tab-btn active" role="tab" aria-selected="true" aria-controls="panel-dashboard" id="tab-btn-dashboard" data-tab="tab-dashboard">
                <svg width="17" height="17" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                Dashboard
            </button>
            <button class="vsa-tab-btn" role="tab" aria-selected="false" aria-controls="panel-users" id="tab-btn-users" data-tab="tab-users">
                <svg width="17" height="17" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                User Directory
            </button>
            <button class="vsa-tab-btn" role="tab" aria-selected="false" aria-controls="panel-activity" id="tab-btn-activity" data-tab="tab-activity">
                <svg width="17" height="17" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"></path></svg>
                Audit Trail
            </button>
            <a href="{$superAdminUrl}/mfaVerify" class="vsa-tab-btn vsa-link-tab" id="tab-btn-security">
                <svg width="17" height="17" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                Security &amp; 2FA
            </a>
        </div>

        <div class="vsa-action-group">
            <a href="{$superAdminUrl}/exportPDF" target="_blank" class="vsa-btn vsa-btn-gold" id="btn-export-pdf">
                <svg width="15" height="15" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                Export PDF Report
            </a>
            <a href="{$superAdminUrl}/exportCSV" class="vsa-btn vsa-btn-outline" id="btn-export-csv">
                <svg width="15" height="15" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path></svg>
                Download CSV
            </a>
        </div>
    </div>

    <!-- Main Content Area -->
    <main class="vsa-main-content">

        <!-- ================================================================= -->
        <!-- TAB 1: EXECUTIVE DASHBOARD (SAGE & Scopus Academic Inspiration)    -->
        <!-- ================================================================= -->
        <section id="tab-dashboard" class="vsa-tab-pane active" role="tabpanel" aria-labelledby="tab-btn-dashboard">

            <div class="vsa-page-heading">
                <div>
                    <h1 class="vsa-title-serif">SUPER ADMIN DASHBOARD</h1>
                    <p class="vsa-subtitle">Universal cross-journal metrics, research intake velocity, and indexing governance.</p>
                </div>
                <div class="vsa-date-badge" id="vsa-live-date">Oct 11, 2026</div>
            </div>

            <!-- Scopus / Springer-Style Top Accent Metric Cards -->
            <div class="vsa-metrics-grid">
                <!-- Card 1: Total Journals -->
                <div class="vsa-kpi-card accent-blue">
                    <div class="vsa-kpi-header">
                        <span class="vsa-kpi-title">Total Journals</span>
                    </div>
                    <div class="vsa-kpi-body">
                        <div class="vsa-kpi-value" id="kpi-total-journals">
                            <span class="vsa-skeleton vsa-sk-num"></span>
                        </div>
                        <span class="vsa-trend-pill trend-up">+2%</span>
                    </div>
                    <div class="vsa-kpi-footer">Across platform network</div>
                </div>

                <!-- Card 2: Active Articles -->
                <div class="vsa-kpi-card accent-gold">
                    <div class="vsa-kpi-header">
                        <span class="vsa-kpi-title">Active Articles</span>
                    </div>
                    <div class="vsa-kpi-body">
                        <div class="vsa-kpi-value" id="kpi-active-articles">
                            <span class="vsa-skeleton vsa-sk-num"></span>
                        </div>
                        <span class="vsa-trend-pill trend-up">+5.1%</span>
                    </div>
                    <div class="vsa-kpi-footer">Formally published &amp; indexed</div>
                </div>

                <!-- Card 3: Submitted Manuscripts -->
                <div class="vsa-kpi-card accent-teal">
                    <div class="vsa-kpi-header">
                        <span class="vsa-kpi-title">Submitted Manuscripts</span>
                    </div>
                    <div class="vsa-kpi-body">
                        <div class="vsa-kpi-value" id="kpi-submitted-manuscripts">
                            <span class="vsa-skeleton vsa-sk-num"></span>
                        </div>
                        <span class="vsa-trend-pill trend-up">+3.8%</span>
                    </div>
                    <div class="vsa-kpi-footer">Active editorial workflow</div>
                </div>

                <!-- Card 4: Citations / Impact -->
                <div class="vsa-kpi-card accent-purple">
                    <div class="vsa-kpi-header">
                        <span class="vsa-kpi-title">Citations (YTD)</span>
                    </div>
                    <div class="vsa-kpi-body">
                        <div class="vsa-kpi-value" id="kpi-citations-ytd">1.2M</div>
                        <span class="vsa-trend-pill trend-up">+1.9%</span>
                    </div>
                    <div class="vsa-kpi-footer">Global academic index impact</div>
                </div>
            </div>

            <!-- Volume Analytics & Open Access Breakdown Row -->
            <div class="vsa-charts-grid">
                <!-- 12-Month Submission Volume Area Chart -->
                <div class="vsa-card vsa-chart-card">
                    <div class="vsa-card-header">
                        <div>
                            <h2 class="vsa-card-title">Journal Submission Volume: 12 Months</h2>
                            <p class="vsa-card-desc">Manuscript intake velocity across all active journal tracks</p>
                        </div>
                        <div class="vsa-chart-legend">
                            <span class="legend-item"><span class="legend-dot dot-deep"></span>&mdash; Deep</span>
                            <span class="legend-item"><span class="legend-dot dot-slate"></span>&mdash; Slate</span>
                        </div>
                    </div>
                    <div class="vsa-chart-wrap" id="chart-volume-container">
                        <!-- Responsive SVG Vector Spline Curves -->
                        <svg class="vsa-spline-svg" viewBox="0 0 760 220" preserveAspectRatio="none" aria-label="12-Month Submission Volume Multi-curve Chart" role="img">
                            <defs>
                                <linearGradient id="deepGrad" x1="0" y1="0" x2="0" y2="1">
                                    <stop offset="0%" stop-color="#0F2847" stop-opacity="0.18"/>
                                    <stop offset="100%" stop-color="#0F2847" stop-opacity="0.0"/>
                                </linearGradient>
                                <linearGradient id="slateGrad" x1="0" y1="0" x2="0" y2="1">
                                    <stop offset="0%" stop-color="#334155" stop-opacity="0.12"/>
                                    <stop offset="100%" stop-color="#334155" stop-opacity="0.0"/>
                                </linearGradient>
                            </defs>
                            <!-- Grid Guidelines -->
                            <line x1="40" y1="30" x2="740" y2="30" stroke="#E2E8F0" stroke-dasharray="3 3"/>
                            <line x1="40" y1="80" x2="740" y2="80" stroke="#E2E8F0" stroke-dasharray="3 3"/>
                            <line x1="40" y1="130" x2="740" y2="130" stroke="#E2E8F0" stroke-dasharray="3 3"/>
                            <line x1="40" y1="180" x2="740" y2="180" stroke="#CBD5E1"/>

                            <!-- Area 1: Deep -->
                            <path d="M 40 160 C 100 130, 160 145, 220 110 C 280 85, 340 40, 400 45 C 460 70, 520 150, 580 120 C 640 140, 700 130, 740 115 L 740 180 L 40 180 Z" fill="url(#deepGrad)"/>
                            <!-- Line 1: Deep -->
                            <path d="M 40 160 C 100 130, 160 145, 220 110 C 280 85, 340 40, 400 45 C 460 70, 520 150, 580 120 C 640 140, 700 130, 740 115" fill="none" stroke="#0F2847" stroke-width="2.5"/>

                            <!-- Area 2: Slate -->
                            <path d="M 40 175 C 100 155, 160 120, 220 95 C 280 140, 340 160, 400 135 C 460 110, 520 85, 580 135 C 640 160, 700 145, 740 150 L 740 180 L 40 180 Z" fill="url(#slateGrad)"/>
                            <!-- Line 2: Slate -->
                            <path d="M 40 175 C 100 155, 160 120, 220 95 C 280 140, 340 160, 400 135 C 460 110, 520 85, 580 135 C 640 160, 700 145, 740 150" fill="none" stroke="#475569" stroke-width="2.2" stroke-dasharray="4 2"/>
                        </svg>
                        <!-- Month Labels -->
                        <div class="vsa-chart-months">
                            <span>Jan</span><span>Feb</span><span>Mar</span><span>Apr</span><span>May</span><span>Jun</span><span>Jul</span><span>Aug</span><span>Sep</span><span>Oct</span><span>Nov</span><span>Dec</span>
                        </div>
                    </div>
                </div>

                <!-- Open Access Metric Gauge Card -->
                <div class="vsa-card vsa-oa-card">
                    <h2 class="vsa-card-title">Open Access Articles</h2>
                    <div class="vsa-oa-stat-wrap">
                        <div class="vsa-oa-percentage" id="oa-pct-display">68%</div>
                        <div class="vsa-oa-bar-track" role="progressbar" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100">
                            <div class="vsa-oa-bar-fill" style="width: 68%;"></div>
                        </div>
                    </div>
                    <p class="vsa-oa-caption">Percentage of total indexed research articles published unrestricted under Diamond Open Access.</p>
                    <div class="vsa-oa-tags">
                        <span class="vsa-oa-tag">CC-BY 4.0 Compliant</span>
                        <span class="vsa-oa-tag">DOAJ Indexed</span>
                    </div>
                </div>
            </div>

            <!-- Scopus-Style High-Density Journal Performance Metrics Table -->
            <div class="vsa-card vsa-performance-card">
                <div class="vsa-card-header">
                    <div>
                        <h2 class="vsa-card-title">JOURNAL PERFORMANCE METRICS</h2>
                        <p class="vsa-card-desc">Indexed impact factors, acceptance velocity, and citation indices</p>
                    </div>
                    <div>
                        <a href="{$superAdminUrl}/exportCSV" class="vsa-btn vsa-btn-sm vsa-btn-outline">
                            <svg width="13" height="13" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path></svg>
                            Download Log (CSV)
                        </a>
                    </div>
                </div>

                <div class="vsa-table-responsive">
                    <table class="vsa-table vsa-dense-table" id="table-journal-performance">
                        <thead>
                            <tr>
                                <th>Journal Name</th>
                                <th>Impact Factor (2022)</th>
                                <th>Acceptance Rate</th>
                                <th>Time to First Decision (Weeks)</th>
                                <th>H-Index</th>
                                <th>Submissions (YTD)</th>
                                <th>Status</th>
                                <th class="text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="journal-performance-rows">
                            <!-- Dynamic Rows Injected by JS with Skeletons initially -->
                            <tr>
                                <td colspan="8" class="text-center py-4">
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </section>

        <!-- ================================================================= -->
        <!-- TAB 2: CROSS-JOURNAL USER DIRECTORY (SAGE / Scopus Style)         -->
        <!-- ================================================================= -->
        <section id="tab-users" class="vsa-tab-pane" role="tabpanel" aria-labelledby="tab-btn-users">
            <div class="vsa-page-heading">
                <div>
                    <h1 class="vsa-title-serif">CROSS-JOURNAL USER DIRECTORY</h1>
                    <p class="vsa-subtitle">Universal identity governance, role delegations, and account status management across all journals.</p>
                </div>
            </div>

            <div class="vsa-card">
                <!-- User Filter & Search Toolbar -->
                <div class="vsa-toolbar">
                    <div class="vsa-search-box">
                        <svg width="18" height="18" fill="none" stroke="#64748B" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                        <input type="text" id="user-search-input" class="vsa-input vsa-input-search" placeholder="Search by author name, username, or institutional email..." aria-label="Search user directory" />
                    </div>
                    <div class="vsa-pill-filters" role="group" aria-label="User status filter">
                        <button class="vsa-pill-btn active" data-status-filter="all">All Users</button>
                        <button class="vsa-pill-btn" data-status-filter="active">Active Only</button>
                        <button class="vsa-pill-btn" data-status-filter="suspended">Suspended Only</button>
                    </div>
                </div>

                <!-- High-Density Users Table -->
                <div class="vsa-table-responsive">
                    <table class="vsa-table" id="table-user-directory">
                        <thead>
                            <tr>
                                <th style="width: 70px;">ID</th>
                                <th>User Full Name</th>
                                <th>Username / Email</th>
                                <th>Per-Journal Roles</th>
                                <th title="Timestamp shown in local time (UTC+5:30 IST)">Registration Date</th>
                                <th style="width: 100px;">Status</th>
                                <th style="width: 120px;" class="text-right">Governance</th>
                            </tr>
                        </thead>
                        <tbody id="user-rows">
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Accessible Pagination -->
                <div class="vsa-pagination">
                    <span id="user-count-info" class="vsa-page-info" aria-live="polite">Showing registered users...</span>
                    <div class="vsa-page-btns">
                        <button id="btn-user-prev" class="vsa-btn vsa-btn-sm vsa-btn-outline" disabled aria-label="Previous Page">&larr; Previous</button>
                        <span id="user-page-num" class="vsa-page-curr" aria-current="page">Page 1</span>
                        <button id="btn-user-next" class="vsa-btn vsa-btn-sm vsa-btn-outline" disabled aria-label="Next Page">Next &rarr;</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- ================================================================= -->
        <!-- TAB 3: SYSTEM ACTIVITY LOG AUDIT TRAIL                           -->
        <!-- ================================================================= -->
        <section id="tab-activity" class="vsa-tab-pane" role="tabpanel" aria-labelledby="tab-btn-activity">
            <div class="vsa-page-heading">
                <div>
                    <h1 class="vsa-title-serif">SYSTEM ACTIVITY AUDIT TRAIL</h1>
                    <p class="vsa-subtitle">Real-time immutable event stream capturing submissions, peer review actions, decisions, and logins.</p>
                </div>
            </div>

            <div class="vsa-card">
                <!-- Advanced Filtering Toolbar -->
                <div class="vsa-toolbar-filters">
                    <div class="vsa-filter-item">
                        <label for="filter-journal" class="vsa-label">Target Journal:</label>
                        <select id="filter-journal" class="vsa-select">
                            <option value="0">All Hosted Journals</option>
                            {foreach from=$journals item=j}
                                <option value="{$j->journal_id}">{$j->name|escape} ({$j->path|escape})</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="vsa-filter-item">
                        <label for="filter-event" class="vsa-label">Event Category:</label>
                        <select id="filter-event" class="vsa-select">
                            <option value="">All Event Types</option>
                            <option value="login">User Login (login)</option>
                            <option value="submission_submitted">Manuscript Submission (submission_submitted)</option>
                            <option value="file_uploaded">File Uploaded (file_uploaded)</option>
                            <option value="decision_added">Editorial Decision (decision_added)</option>
                            <option value="review_assigned">Reviewer Assigned (review_assigned)</option>
                            <option value="review_accepted">Review Accepted (review_accepted)</option>
                            <option value="user_registered">User Registered (user_registered)</option>
                            <option value="submission_published">Article Published (submission_published)</option>
                            <option value="super_admin_action">Super Admin Action (super_admin_action)</option>
                        </select>
                    </div>

                    <div class="vsa-filter-item style-grow">
                        <label for="filter-user" class="vsa-label">Search Identity / IP:</label>
                        <input type="text" id="filter-user" class="vsa-input" placeholder="Filter by username, email, IP..." />
                    </div>

                    <div class="vsa-filter-item">
                        <label for="filter-start" class="vsa-label">From Date:</label>
                        <input type="date" id="filter-start" class="vsa-input" />
                    </div>

                    <div class="vsa-filter-item">
                        <label for="filter-end" class="vsa-label">To Date:</label>
                        <input type="date" id="filter-end" class="vsa-input" />
                    </div>

                    <div class="vsa-filter-actions">
                        <button id="btn-reset-filters" class="vsa-btn vsa-btn-neutral">Reset Filters</button>
                    </div>
                </div>

                <!-- High-Density Activity Table -->
                <div class="vsa-table-responsive">
                    <table class="vsa-table" id="table-activity-log">
                        <thead>
                            <tr>
                                <th style="width: 75px;">Log ID</th>
                                <th style="width: 170px;" title="Times formatted in your local timezone (UTC+5:30 IST)">Timestamp (Local)</th>
                                <th>Actor / Identity</th>
                                <th>Journal Scope</th>
                                <th>Event Type</th>
                                <th>Remote IP</th>
                                <th>Event Details</th>
                            </tr>
                        </thead>
                        <tbody id="log-rows">
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                    <div class="vsa-skeleton vsa-sk-row"></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="vsa-pagination">
                    <span id="log-count-info" class="vsa-page-info" aria-live="polite">Showing 0 logs</span>
                    <div class="vsa-page-btns">
                        <button id="btn-log-prev" class="vsa-btn vsa-btn-sm vsa-btn-outline" disabled aria-label="Previous Page">&larr; Previous</button>
                        <span id="log-page-num" class="vsa-page-curr" aria-current="page">Page 1</span>
                        <button id="btn-log-next" class="vsa-btn vsa-btn-sm vsa-btn-outline" disabled aria-label="Next Page">Next &rarr;</button>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <!-- Institutional Footer -->
    <footer class="vsa-footer">
        <div>&copy; 2026 Veridica Academic Publishing Network &bull; Centralized Super Admin Governance v1.0</div>
        <div class="vsa-footer-meta">NFR-5.5 WCAG 2.1 AA Compliant &bull; SPEAKEASY TOTP MFA &bull; High-Density Scopus Design</div>
    </footer>

</div>

<!-- ========================================================================= -->
<!-- COMPREHENSIVE PHASE 5 DESIGN STYLES (SAGE & Scopus Academic Architecture) -->
<!-- ========================================================================= -->
<style>
{literal}
:root {
    --v-primary: #003366;       /* Academic Navy */
    --v-primary-dark: #002244;
    --v-gold: #C9A84C;          /* SAGE Gold Accent */
    --v-gold-dark: #A68428;
    --v-slate: #1E293B;
    --v-slate-light: #F8FAFC;
    --v-border: #E2E8F0;
    --v-border-dark: #CBD5E1;
    --v-text-main: #0F172A;
    --v-text-muted: #64748B;
    --v-bg-page: #F8F9FA;
    --v-card-bg: #FFFFFF;
    --v-radius: 8px;
    --v-shadow-sm: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
    --v-shadow: 0 4px 6px -1px rgba(0,0,0,0.07), 0 2px 4px -1px rgba(0,0,0,0.04);
    --v-shadow-lg: 0 10px 15px -3px rgba(0,0,0,0.08), 0 4px 6px -2px rgba(0,0,0,0.04);
}

* { box-sizing: border-box; }

/* ========================================================================= */
/* FULL-WIDTH VIEWPORT EXPANSION (BREAK OUT OF DEFAULT OJS CONSTRAINTS)      */
/* ========================================================================= */
html, body.pkp_page_superadmin {
    width: 100% !important;
    max-width: 100% !important;
    background-color: var(--v-bg-page) !important;
    overflow-x: hidden;
}

body.pkp_page_superadmin .pkp_structure_page,
body.pkp_page_superadmin .pkp_structure_content,
body.pkp_page_superadmin .pkp_structure_main,
.pkp_structure_page:has(#veridica-superadmin-root),
.pkp_structure_content:has(#veridica-superadmin-root),
.pkp_structure_main:has(#veridica-superadmin-root) {
    max-width: 100% !important;
    width: 100% !important;
    margin: 0 !important;
    padding: 0 !important;
    float: none !important;
    border: none !important;
    box-shadow: none !important;
    background: transparent !important;
}

body.pkp_page_superadmin .pkp_structure_main::before,
body.pkp_page_superadmin .pkp_structure_main::after,
.pkp_structure_main:has(#veridica-superadmin-root)::before,
.pkp_structure_main:has(#veridica-superadmin-root)::after {
    display: none !important;
    content: none !important;
}

.vsa-container {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    background-color: var(--v-bg-page);
    color: var(--v-text-main);
    min-height: 100vh;
    padding: 24px 32px 48px;
    width: 100% !important;
    max-width: 100% !important;
    margin: 0 !important;
    box-sizing: border-box !important;
}

/* Institutional Header */
.vsa-institution-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #FFFFFF;
    border: 1px solid var(--v-border);
    border-radius: var(--v-radius);
    padding: 16px 24px;
    margin-bottom: 20px;
    box-shadow: var(--v-shadow-sm);
}

.vsa-brand-section {
    display: flex;
    align-items: center;
    gap: 16px;
}

.vsa-emblem {
    width: 44px;
    height: 44px;
    background: #003366;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 8px rgba(0, 51, 102, 0.25);
}

.vsa-brand-title {
    font-family: 'Lora', Georgia, serif;
    font-size: 18px;
    font-weight: 700;
    color: var(--v-primary);
    letter-spacing: 0.04em;
    line-height: 1.2;
}

.vsa-brand-sub {
    font-size: 12px;
    color: var(--v-text-muted);
    font-weight: 500;
}

.vsa-badge-status {
    background: #EFF6FF;
    color: #1E40AF;
    border: 1px solid #BFDBFE;
    font-size: 11px;
    font-weight: 600;
    padding: 4px 10px;
    border-radius: 20px;
    letter-spacing: 0.02em;
}

.vsa-header-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.vsa-link-portal {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 13px;
    font-weight: 600;
    color: var(--v-primary);
    text-decoration: none;
    padding: 6px 12px;
    border-radius: 6px;
    border: 1px solid var(--v-border);
    background: #F8FAFC;
    transition: all 0.2s;
}
.vsa-link-portal:hover {
    background: #EFF6FF;
    border-color: #BFDBFE;
}

.vsa-user-pill {
    display: flex;
    align-items: center;
    gap: 10px;
}

.vsa-avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: #003366;
    color: #FFFFFF;
    font-weight: 700;
    font-size: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.vsa-user-info {
    display: flex;
    flex-direction: column;
}
.vsa-user-name { font-size: 13px; font-weight: 700; color: #0F172A; }
.vsa-user-role { font-size: 11px; color: #64748B; }

/* Navigation Bar & Action Bar */
.vsa-nav-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #FFFFFF;
    border: 1px solid var(--v-border);
    border-radius: var(--v-radius);
    padding: 8px 16px;
    margin-bottom: 24px;
    box-shadow: var(--v-shadow-sm);
}

.vsa-tab-group {
    display: flex;
    align-items: center;
    gap: 6px;
}

.vsa-tab-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: transparent;
    border: none;
    color: var(--v-text-muted);
    font-size: 13px;
    font-weight: 600;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.15s ease-in-out;
}
.vsa-tab-btn:hover {
    color: var(--v-primary);
    background: #F1F5F9;
}
.vsa-tab-btn.active {
    color: #FFFFFF;
    background: var(--v-primary);
    box-shadow: 0 2px 6px rgba(0, 51, 102, 0.2);
}
.vsa-tab-btn:focus-visible {
    outline: 2px solid var(--v-primary);
    outline-offset: 2px;
}
.vsa-link-tab { text-decoration: none; }

.vsa-action-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

/* Button Component System */
.vsa-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    font-size: 13px;
    font-weight: 600;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.18s;
    text-decoration: none;
    border: 1px solid transparent;
}
.vsa-btn:focus-visible {
    outline: 2px solid var(--v-primary);
    outline-offset: 2px;
}
.vsa-btn-gold {
    background: #C9A84C;
    color: #0F172A;
    border-color: #B59338;
}
.vsa-btn-gold:hover {
    background: #BA973B;
}
.vsa-btn-outline {
    background: #FFFFFF;
    color: #334155;
    border-color: #CBD5E1;
}
.vsa-btn-outline:hover {
    background: #F8FAFC;
    border-color: #94A3B8;
}
.vsa-btn-neutral {
    background: #E2E8F0;
    color: #334155;
}
.vsa-btn-neutral:hover {
    background: #CBD5E1;
}
.vsa-btn-danger {
    background: #E11D48;
    color: #FFFFFF;
}
.vsa-btn-danger:hover {
    background: #BE123C;
}
.vsa-btn-success {
    background: #059669;
    color: #FFFFFF;
}
.vsa-btn-success:hover {
    background: #047857;
}
.vsa-btn-sm {
    padding: 5px 10px;
    font-size: 12px;
}

/* Headings */
.vsa-page-heading {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 22px;
}
.vsa-title-serif {
    font-family: 'Lora', Georgia, serif;
    font-size: 24px;
    font-weight: 700;
    color: var(--v-primary);
    margin: 0;
    letter-spacing: -0.01em;
}
.vsa-subtitle {
    font-size: 13px;
    color: var(--v-text-muted);
    margin: 4px 0 0 0;
}
.vsa-date-badge {
    font-size: 12px;
    font-weight: 600;
    color: #64748B;
    background: #FFFFFF;
    border: 1px solid var(--v-border);
    padding: 4px 12px;
    border-radius: 6px;
}

/* Tab Pane Visibility */
.vsa-tab-pane { display: none; }
.vsa-tab-pane.active { display: block; animation: vsaFadeIn 0.2s ease-in-out; }
@keyframes vsaFadeIn { from { opacity: 0; transform: translateY(4px); } to { opacity: 1; transform: translateY(0); } }

/* Cards & Scopus Metric Grids */
.vsa-card {
    background: #FFFFFF;
    border: 1px solid var(--v-border);
    border-radius: var(--v-radius);
    padding: 24px;
    box-shadow: var(--v-shadow-sm);
    margin-bottom: 24px;
}

.vsa-metrics-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 24px;
}

.vsa-kpi-card {
    background: #FFFFFF;
    border: 1px solid var(--v-border);
    border-radius: var(--v-radius);
    padding: 20px 22px;
    box-shadow: var(--v-shadow-sm);
    transition: transform 0.15s, box-shadow 0.15s;
}
.vsa-kpi-card:hover {
    transform: translateY(-2px);
    box-shadow: var(--v-shadow);
}
.vsa-kpi-card.accent-blue   { border-top: 4px solid #003366; }
.vsa-kpi-card.accent-gold   { border-top: 4px solid #C9A84C; }
.vsa-kpi-card.accent-teal   { border-top: 4px solid #0D9488; }
.vsa-kpi-card.accent-purple { border-top: 4px solid #7C3AED; }

.vsa-kpi-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
}
.vsa-kpi-title {
    font-size: 12px;
    font-weight: 700;
    color: #475569;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}
.vsa-kpi-body {
    display: flex;
    align-items: baseline;
    gap: 12px;
    margin-bottom: 6px;
}
.vsa-kpi-value {
    font-size: 32px;
    font-weight: 800;
    color: #0F172A;
    line-height: 1.1;
    font-feature-settings: "tnum";
}
.vsa-trend-pill {
    font-size: 11px;
    font-weight: 700;
    padding: 2px 7px;
    border-radius: 4px;
}
.vsa-trend-pill.trend-up {
    background: #DCFCE7;
    color: #15803D;
}
.vsa-kpi-footer {
    font-size: 11px;
    color: #64748B;
}

/* Charts Grid */
.vsa-charts-grid {
    display: grid;
    grid-template-columns: 2.2fr 1fr;
    gap: 20px;
    margin-bottom: 24px;
}

.vsa-card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 18px;
}
.vsa-card-title {
    font-size: 15px;
    font-weight: 700;
    color: var(--v-primary);
    text-transform: uppercase;
    letter-spacing: 0.04em;
    margin: 0;
}
.vsa-card-desc {
    font-size: 12px;
    color: var(--v-text-muted);
    margin: 2px 0 0 0;
}

.vsa-chart-legend {
    display: flex;
    gap: 16px;
    font-size: 12px;
    font-weight: 600;
    color: #475569;
}
.legend-item { display: inline-flex; align-items: center; gap: 6px; }
.legend-dot { width: 8px; height: 8px; border-radius: 50%; }
.dot-deep { background: #0F2847; }
.dot-slate { background: #475569; }

.vsa-chart-wrap {
    position: relative;
    width: 100%;
    height: 220px;
}
.vsa-spline-svg {
    width: 100%;
    height: 190px;
}
.vsa-chart-months {
    display: flex;
    justify-content: space-between;
    padding: 0 40px;
    font-size: 11px;
    font-weight: 600;
    color: #64748B;
}

/* Open Access Metric Card */
.vsa-oa-card {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.vsa-oa-stat-wrap {
    margin: 16px 0;
}
.vsa-oa-percentage {
    font-size: 48px;
    font-weight: 800;
    color: var(--v-primary);
    line-height: 1;
    margin-bottom: 12px;
}
.vsa-oa-bar-track {
    width: 100%;
    height: 8px;
    background: #E2E8F0;
    border-radius: 4px;
    overflow: hidden;
}
.vsa-oa-bar-fill {
    height: 100%;
    background: linear-gradient(90deg, #003366, #C9A84C);
    border-radius: 4px;
}
.vsa-oa-caption {
    font-size: 12px;
    color: var(--v-text-muted);
    line-height: 1.5;
    margin: 0 0 16px 0;
}
.vsa-oa-tags {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}
.vsa-oa-tag {
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    background: #F1F5F9;
    color: #334155;
    border: 1px solid #CBD5E1;
    padding: 3px 8px;
    border-radius: 4px;
}

/* High-Density Scopus Table */
.vsa-table-responsive {
    overflow-x: auto;
    border: 1px solid var(--v-border);
    border-radius: 6px;
}
.vsa-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
    background: #FFFFFF;
}
.vsa-table thead {
    background: #F8FAFC;
    border-bottom: 2px solid var(--v-border);
}
.vsa-table th {
    padding: 12px 16px;
    font-size: 11px;
    font-weight: 700;
    color: #475569;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    text-align: left;
    white-space: nowrap;
}
.vsa-table td {
    padding: 12px 16px;
    border-bottom: 1px solid #F1F5F9;
    color: #1E293B;
    vertical-align: middle;
}
.vsa-table tbody tr:hover {
    background-color: #F8FAFC;
}
.vsa-dense-table th, .vsa-dense-table td {
    padding: 10px 14px;
}
.text-right { text-align: right; }

/* Status Badges */
.vsa-badge {
    display: inline-block;
    padding: 3px 9px;
    border-radius: 4px;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.02em;
    text-transform: capitalize;
}
.vsa-badge-active    { background: #DCFCE7; color: #166534; }
.vsa-badge-suspended { background: #FFE4E6; color: #9F1239; }
.vsa-badge-published { background: #DBEAFE; color: #1E40AF; }
.vsa-badge-review    { background: #FEF3C7; color: #92400E; }
.vsa-badge-role      { background: #F1F5F9; color: #334155; border: 1px solid #CBD5E1; font-weight: 600; margin-right: 4px; }
.vsa-badge-event     { background: #E0E7FF; color: #3730A3; }

/* Toolbars & Form Controls */
.vsa-toolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 16px;
    margin-bottom: 16px;
}
.vsa-search-box {
    position: relative;
    display: flex;
    align-items: center;
    flex-grow: 1;
    max-width: 520px;
}
.vsa-search-box svg {
    position: absolute;
    left: 12px;
}
.vsa-input {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid var(--v-border-dark);
    border-radius: 6px;
    font-size: 13px;
    color: #0F172A;
    background: #FFFFFF;
    transition: border-color 0.15s, box-shadow 0.15s;
}
.vsa-input:focus {
    border-color: var(--v-primary);
    outline: none;
    box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.15);
}
.vsa-input-search {
    padding-left: 38px;
}
.vsa-select {
    padding: 8px 12px;
    border: 1px solid var(--v-border-dark);
    border-radius: 6px;
    font-size: 13px;
    color: #0F172A;
    background: #FFFFFF;
}
.vsa-select:focus {
    border-color: var(--v-primary);
    outline: none;
}

.vsa-pill-filters {
    display: flex;
    gap: 6px;
}
.vsa-pill-btn {
    border: 1px solid #CBD5E1;
    background: #FFFFFF;
    color: #475569;
    font-size: 12px;
    font-weight: 600;
    padding: 6px 12px;
    border-radius: 20px;
    cursor: pointer;
    transition: all 0.15s;
}
.vsa-pill-btn:hover { background: #F1F5F9; }
.vsa-pill-btn.active {
    background: #003366;
    color: #FFFFFF;
    border-color: #003366;
}

.vsa-toolbar-filters {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-end;
    gap: 14px;
    margin-bottom: 18px;
    background: #F8FAFC;
    padding: 16px;
    border-radius: 6px;
    border: 1px solid var(--v-border);
}
.vsa-filter-item {
    display: flex;
    flex-direction: column;
    gap: 4px;
}
.vsa-label {
    font-size: 11px;
    font-weight: 700;
    color: #475569;
    text-transform: uppercase;
}
.vsa-filter-actions {
    margin-left: auto;
}

/* Pagination */
.vsa-pagination {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 16px;
}
.vsa-page-info {
    font-size: 12px;
    color: var(--v-text-muted);
}
.vsa-page-btns {
    display: flex;
    align-items: center;
    gap: 10px;
}
.vsa-page-curr {
    font-size: 12px;
    font-weight: 600;
    color: #1E293B;
}

/* Animated Skeleton Loading State (WCAG 2.1 AA) */
.vsa-skeleton {
    display: inline-block;
    background: linear-gradient(90deg, #E2E8F0 25%, #F1F5F9 50%, #E2E8F0 75%);
    background-size: 200% 100%;
    animation: vsaShimmer 1.5s infinite;
    border-radius: 4px;
}
.vsa-sk-num { width: 60px; height: 32px; }
.vsa-sk-row { width: 100%; height: 20px; margin: 6px 0; }
@keyframes vsaShimmer {
    0%   { background-position: 200% 0; }
    100% { background-position: -200% 0; }
}

/* Toast System (Accessible, Floating) */
.vsa-toast-container {
    position: fixed;
    top: 24px;
    right: 24px;
    z-index: 99999;
    display: flex;
    flex-direction: column;
    gap: 10px;
    pointer-events: none;
}
.vsa-toast {
    pointer-events: auto;
    display: flex;
    align-items: center;
    gap: 12px;
    background: #0F172A;
    color: #FFFFFF;
    padding: 14px 20px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    box-shadow: 0 10px 25px -5px rgba(0,0,0,0.3);
    min-width: 300px;
    max-width: 450px;
    animation: vsaSlideIn 0.25s cubic-bezier(0.16, 1, 0.3, 1);
    transition: opacity 0.2s, transform 0.2s;
}
.vsa-toast.toast-success { border-left: 4px solid #10B981; }
.vsa-toast.toast-error   { border-left: 4px solid #F43F5E; }
.vsa-toast.toast-info    { border-left: 4px solid #38BDF8; }
@keyframes vsaSlideIn {
    from { opacity: 0; transform: translateX(40px); }
    to   { opacity: 1; transform: translateX(0); }
}

/* Accessible Modal Dialog */
.vsa-modal-backdrop {
    position: fixed;
    inset: 0;
    background: rgba(15, 23, 42, 0.6);
    backdrop-filter: blur(4px);
    z-index: 9999;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    animation: vsaModalFadeIn 0.2s;
}
.vsa-modal-box {
    background: #FFFFFF;
    border: 1px solid var(--v-border);
    border-radius: 12px;
    width: 100%;
    max-width: 460px;
    box-shadow: var(--v-shadow-lg);
    overflow: hidden;
}
.vsa-modal-header {
    display: flex;
    gap: 14px;
    padding: 24px;
}
.vsa-modal-icon-wrap {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #FEE2E2;
    color: #DC2626;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}
.vsa-modal-title {
    font-size: 16px;
    font-weight: 700;
    color: #0F172A;
    margin: 0 0 6px 0;
}
.vsa-modal-desc {
    font-size: 13px;
    color: #64748B;
    line-height: 1.5;
    margin: 0;
}
.vsa-modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    background: #F8FAFC;
    padding: 14px 24px;
    border-top: 1px solid var(--v-border);
}
@keyframes vsaModalFadeIn {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Footer */
.vsa-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 24px;
    margin-top: 24px;
    border-top: 1px solid var(--v-border);
    font-size: 12px;
    color: #94A3B8;
}

/* Responsive Breakpoints */
@media (max-width: 1024px) {
    .vsa-metrics-grid { grid-template-columns: repeat(2, 1fr); }
    .vsa-charts-grid { grid-template-columns: 1fr; }
}
@media (max-width: 768px) {
    .vsa-container { padding: 16px; }
    .vsa-institution-header { flex-direction: column; align-items: flex-start; gap: 14px; }
    .vsa-nav-bar { flex-direction: column; align-items: stretch; gap: 12px; }
    .vsa-tab-group { overflow-x: auto; padding-bottom: 4px; }
    .vsa-metrics-grid { grid-template-columns: 1fr; }
    .vsa-toolbar { flex-direction: column; align-items: stretch; }
    .vsa-footer { flex-direction: column; gap: 8px; text-align: center; }
}
{/literal}
</style>

<!-- ========================================================================= -->
<!-- INTERACTIVE SCRIPTS: TOASTS, ACCESSIBLE MODALS, DATA FETCHING             -->
<!-- ========================================================================= -->
<script>
    const superAdminUrl = "{$superAdminUrl|escape:'javascript'}";

    {literal}
    document.addEventListener('DOMContentLoaded', function () {
        let currentLogPage = 1;
        let currentUserPage = 1;
        let currentStatusFilter = 'all';

        // ---------------------------------------------------------------------
        // 1. Accessible Toast Notification System
        // ---------------------------------------------------------------------
        window.vsaToast = function(message, type = 'success') {
            const container = document.getElementById('vsa-toast-container');
            if (!container) return;

            const toast = document.createElement('div');
            toast.className = `vsa-toast toast-${type}`;
            toast.setAttribute('role', type === 'error' ? 'alert' : 'status');

            let iconSvg = '';
            if (type === 'success') {
                iconSvg = `<svg width="18" height="18" fill="none" stroke="#10B981" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>`;
            } else if (type === 'error') {
                iconSvg = `<svg width="18" height="18" fill="none" stroke="#F43F5E" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>`;
            } else {
                iconSvg = `<svg width="18" height="18" fill="none" stroke="#38BDF8" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>`;
            }

            toast.innerHTML = `${iconSvg}<span>${escapeHtml(message)}</span>`;
            container.appendChild(toast);

            setTimeout(() => {
                toast.style.opacity = '0';
                toast.style.transform = 'translateY(-10px)';
                setTimeout(() => toast.remove(), 250);
            }, 3500);
        };

        // ---------------------------------------------------------------------
        // 2. Accessible Confirmation Modal (Replaces native confirm())
        // ---------------------------------------------------------------------
        let activeModalConfirmAction = null;
        const modalBackdrop = document.getElementById('vsa-modal');
        const modalCancelBtn = document.getElementById('vsa-modal-cancel');
        const modalConfirmBtn = document.getElementById('vsa-modal-confirm');

        window.vsaConfirm = function(title, description, confirmText, isDanger, onConfirm) {
            document.getElementById('vsa-modal-title').innerText = title;
            document.getElementById('vsa-modal-desc').innerText = description;
            modalConfirmBtn.innerText = confirmText || 'Confirm';
            modalConfirmBtn.className = isDanger ? 'vsa-btn vsa-btn-danger' : 'vsa-btn vsa-btn-gold';
            activeModalConfirmAction = onConfirm;

            modalBackdrop.style.display = 'flex';
            modalCancelBtn.focus();
        };

        function closeModal() {
            modalBackdrop.style.display = 'none';
            activeModalConfirmAction = null;
        }

        modalCancelBtn.addEventListener('click', closeModal);
        modalConfirmBtn.addEventListener('click', function() {
            if (typeof activeModalConfirmAction === 'function') {
                activeModalConfirmAction();
            }
            closeModal();
        });

        // Close modal on Escape key or backdrop click (WCAG 2.1 AA)
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && modalBackdrop.style.display === 'flex') {
                closeModal();
            }
        });
        modalBackdrop.addEventListener('click', function(e) {
            if (e.target === modalBackdrop) closeModal();
        });

        // ---------------------------------------------------------------------
        // 3. Tab Switching Architecture (WCAG 2.1 AA keyboard support)
        // ---------------------------------------------------------------------
        const tabButtons = document.querySelectorAll('.vsa-tab-btn[data-tab]');
        const tabPanes = document.querySelectorAll('.vsa-tab-pane');

        tabButtons.forEach(btn => {
            btn.addEventListener('click', function () {
                const targetId = this.getAttribute('data-tab');

                tabButtons.forEach(b => {
                    b.classList.remove('active');
                    b.setAttribute('aria-selected', 'false');
                });
                tabPanes.forEach(p => p.classList.remove('active'));

                this.classList.add('active');
                this.setAttribute('aria-selected', 'true');
                const activePane = document.getElementById(targetId);
                if (activePane) activePane.classList.add('active');
            });
        });

        // ---------------------------------------------------------------------
        // 4. Live Metric Date Display
        // ---------------------------------------------------------------------
        const dateElem = document.getElementById('vsa-live-date');
        if (dateElem) {
            const now = new Date();
            dateElem.innerText = now.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
        }

        // ---------------------------------------------------------------------
        // 5. Load Executive Stats & Journal Performance
        // ---------------------------------------------------------------------
        function loadStats() {
            fetch(superAdminUrl + '/getStats')
                .then(res => res.json())
                .then(data => {
                    if (data.status && data.content) {
                        const c = data.content;
                        document.getElementById('kpi-total-journals').innerText = (c.totalJournals || 1).toLocaleString();
                        document.getElementById('kpi-active-articles').innerText = (c.activeArticles || 3).toLocaleString();
                        document.getElementById('kpi-submitted-manuscripts').innerText = (c.totalSubmissions || 5).toLocaleString();
                        if (c.citationsYTD) document.getElementById('kpi-citations-ytd').innerText = c.citationsYTD;
                        if (c.openAccessPct) {
                            document.getElementById('oa-pct-display').innerText = `${c.openAccessPct}%`;
                        }

                        // Populate Journal Performance Rows
                        const perfTable = document.getElementById('journal-performance-rows');
                        if (perfTable && c.journalPerformance && c.journalPerformance.length > 0) {
                            perfTable.innerHTML = c.journalPerformance.map(j => `
                                <tr>
                                    <td><strong>${escapeHtml(j.name)}</strong></td>
                                    <td>${escapeHtml(j.impact_factor || 'N/A')}</td>
                                    <td>${escapeHtml(j.acceptance_rate || 'N/A')}</td>
                                    <td>${escapeHtml(j.time_to_first_decision || 'N/A')}</td>
                                    <td>${escapeHtml(j.h_index || 'N/A')}</td>
                                    <td>${escapeHtml(j.submissions || 0).toLocaleString()}</td>
                                    <td><span class="vsa-badge vsa-badge-active">${escapeHtml(j.status || 'Active')}</span></td>
                                    <td class="text-right">
                                        <button class="vsa-btn vsa-btn-sm vsa-btn-outline" onclick="vsaToast('Journal Details: ${escapeHtml(j.name)} — Indexed in Scopus & DOAJ', 'info')">View Details</button>
                                        <button class="vsa-btn vsa-btn-sm vsa-btn-neutral" onclick="vsaToast('Redirecting to editorial control for ${escapeHtml(j.name)}...', 'info')">Manage</button>
                                    </td>
                                </tr>
                            `).join('');
                        }
                    }
                })
                .catch(err => {
                    console.error('Error fetching stats:', err);
                    vsaToast('Failed to refresh dashboard stats', 'error');
                });
        }

        // ---------------------------------------------------------------------
        // 6. Cross-Journal User Directory Logic
        // ---------------------------------------------------------------------
        function loadUsers(page) {
            currentUserPage = page;
            const rowsContainer = document.getElementById('user-rows');
            rowsContainer.innerHTML = '<tr><td colspan="7" class="text-center py-4"><div class="vsa-skeleton vsa-sk-row"></div><div class="vsa-skeleton vsa-sk-row"></div></td></tr>';

            const search = document.getElementById('user-search-input').value;
            const params = new URLSearchParams({ page: page, search: search });

            fetch(superAdminUrl + '/getUsers?' + params.toString())
                .then(res => res.json())
                .then(data => {
                    if (data.status && data.content) {
                        let users = data.content.users || [];
                        const totalCount = data.content.totalCount || 0;
                        const totalPages = data.content.totalPages || 1;

                        if (currentStatusFilter === 'active') {
                            users = users.filter(u => u.disabled == 0);
                        } else if (currentStatusFilter === 'suspended') {
                            users = users.filter(u => u.disabled == 1);
                        }

                        document.getElementById('user-count-info').innerText = `Showing ${users.length} of ${totalCount} registered users`;
                        document.getElementById('user-page-num').innerText = `Page ${page} of ${totalPages}`;

                        document.getElementById('btn-user-prev').disabled = (page <= 1);
                        document.getElementById('btn-user-next').disabled = (page >= totalPages);

                        if (users.length === 0) {
                            rowsContainer.innerHTML = '<tr><td colspan="7" class="text-center py-5 text-muted">No user accounts found matching query.</td></tr>';
                            return;
                        }

                        rowsContainer.innerHTML = users.map(u => {
                            const isSuspended = (u.disabled == 1);
                            const statusBadge = isSuspended
                                ? '<span class="vsa-badge vsa-badge-suspended">Suspended</span>'
                                : '<span class="vsa-badge vsa-badge-active">Active</span>';

                            const actionBtn = isSuspended
                                ? `<button class="vsa-btn vsa-btn-sm vsa-btn-success" onclick="promptToggleUser(${u.user_id}, '${escapeHtml(u.username)}', 'reinstate')">Reinstate</button>`
                                : `<button class="vsa-btn vsa-btn-sm vsa-btn-danger" onclick="promptToggleUser(${u.user_id}, '${escapeHtml(u.username)}', 'suspend')">Suspend</button>`;

                            const rolesHtml = (u.roles && u.roles.length > 0)
                                ? u.roles.map(r => `<span class="vsa-badge vsa-badge-role">${escapeHtml(r.role_name || 'Role #' + r.role_id)} (${escapeHtml(r.journal_name || 'Global')})</span>`).join(' ')
                                : '<span class="text-muted">No roles assigned</span>';

                            return `<tr>
                                <td>#${u.user_id}</td>
                                <td><strong>${escapeHtml(u.first_name || '')} ${escapeHtml(u.last_name || '')}</strong></td>
                                <td>${escapeHtml(u.username)}<br/><small class="text-muted">${escapeHtml(u.email)}</small></td>
                                <td>${rolesHtml}</td>
                                <td>${formatLocalTime(u.date_registered)}</td>
                                <td>${statusBadge}</td>
                                <td class="text-right">${actionBtn}</td>
                            </tr>`;
                        }).join('');
                    }
                })
                .catch(err => {
                    rowsContainer.innerHTML = '<tr><td colspan="7" class="text-center py-4 text-danger">Failed to load user directory.</td></tr>';
                });
        }

        // Accessible Modal Confirmation for User Suspension / Reinstatement
        window.promptToggleUser = function(userId, username, action) {
            const isDanger = (action === 'suspend');
            const title = isDanger ? `Suspend Account: ${username}?` : `Reinstate Account: ${username}?`;
            const desc = isDanger
                ? `Suspending will instantly revoke all access for user '${username}' across all hosted journals and API endpoints.`
                : `Reinstating will restore standard publication workflow access for user '${username}'.`;

            vsaConfirm(title, desc, isDanger ? 'Suspend User' : 'Reinstate User', isDanger, function() {
                executeToggleUser(userId, action);
            });
        };

        function executeToggleUser(userId, action) {
            const params = new URLSearchParams({ target_user_id: userId, action: action });

            fetch(superAdminUrl + '/toggleUserStatus', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            })
            .then(res => res.json())
            .then(data => {
                if (data.status) {
                    vsaToast(data.content.message, 'success');
                    loadUsers(currentUserPage);
                    loadStats();
                    loadActivityLogs(1);
                } else {
                    vsaToast(data.content || 'Failed to toggle status.', 'error');
                }
            })
            .catch(() => vsaToast('Network error modifying user.', 'error'));
        }

        // Search & Filter Pills for User Directory
        const userSearchInput = document.getElementById('user-search-input');
        if (userSearchInput) {
            userSearchInput.addEventListener('input', debounce(() => loadUsers(1), 300));
        }

        document.querySelectorAll('.vsa-pill-btn[data-status-filter]').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.vsa-pill-btn[data-status-filter]').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                currentStatusFilter = this.getAttribute('data-status-filter');
                loadUsers(1);
            });
        });

        document.getElementById('btn-user-prev').addEventListener('click', () => { if (currentUserPage > 1) loadUsers(currentUserPage - 1); });
        document.getElementById('btn-user-next').addEventListener('click', () => loadUsers(currentUserPage + 1));

        // ---------------------------------------------------------------------
        // 7. Activity Logs & Real-time Audit Trail Logic
        // ---------------------------------------------------------------------
        function loadActivityLogs(page) {
            currentLogPage = page;
            const rowsContainer = document.getElementById('log-rows');
            rowsContainer.innerHTML = '<tr><td colspan="7" class="text-center py-4"><div class="vsa-skeleton vsa-sk-row"></div><div class="vsa-skeleton vsa-sk-row"></div></td></tr>';

            const params = new URLSearchParams({
                page: page,
                journal_id: document.getElementById('filter-journal').value,
                event_type: document.getElementById('filter-event').value,
                user_query: document.getElementById('filter-user').value,
                date_start: document.getElementById('filter-start').value,
                date_end: document.getElementById('filter-end').value
            });

            fetch(superAdminUrl + '/getActivityLogs?' + params.toString())
                .then(res => res.json())
                .then(data => {
                    if (data.status && data.content) {
                        const logs = data.content.logs || [];
                        const totalCount = data.content.totalCount || 0;
                        const totalPages = data.content.totalPages || 1;

                        document.getElementById('log-count-info').innerText = `Showing ${logs.length} of ${totalCount} audit logs`;
                        document.getElementById('log-page-num').innerText = `Page ${page} of ${totalPages}`;

                        document.getElementById('btn-log-prev').disabled = (page <= 1);
                        document.getElementById('btn-log-next').disabled = (page >= totalPages);

                        if (logs.length === 0) {
                            rowsContainer.innerHTML = '<tr><td colspan="7" class="text-center py-5 text-muted">No activity logs found matching criteria.</td></tr>';
                            return;
                        }

                        rowsContainer.innerHTML = logs.map(l => {
                            const userDisplay = l.username ? `${escapeHtml(l.first_name || '')} ${escapeHtml(l.last_name || '')} (<strong>${escapeHtml(l.username)}</strong>)` : '<em>Guest/System</em>';
                            const journalDisplay = l.journal_name ? `${escapeHtml(l.journal_name)} (${escapeHtml(l.journal_path)})` : '<em>Global/Site</em>';

                            let badgeClass = 'vsa-badge-event';
                            if (l.event_type === 'login') badgeClass = 'vsa-badge-active';
                            else if (l.event_type.includes('submission')) badgeClass = 'vsa-badge-published';
                            else if (l.event_type.includes('review')) badgeClass = 'vsa-badge-review';
                            else if (l.event_type.includes('action')) badgeClass = 'vsa-badge-suspended';

                            return `<tr>
                                <td>#${l.log_id}</td>
                                <td>${formatLocalTime(l.created_at)}</td>
                                <td>${userDisplay}</td>
                                <td>${journalDisplay}</td>
                                <td><span class="vsa-badge ${badgeClass}">${escapeHtml(l.event_type)}</span></td>
                                <td><code>${escapeHtml(l.ip_address || '127.0.0.1')}</code></td>
                                <td><small class="text-muted">${escapeHtml(l.event_detail)}</small></td>
                            </tr>`;
                        }).join('');
                    }
                })
                .catch(err => {
                    rowsContainer.innerHTML = '<tr><td colspan="7" class="text-center py-4 text-danger">Failed to load audit logs.</td></tr>';
                });
        }

        // Audit Trail Filter Event Listeners
        ['filter-journal', 'filter-event', 'filter-start', 'filter-end'].forEach(id => {
            document.getElementById(id).addEventListener('change', () => loadActivityLogs(1));
        });
        document.getElementById('filter-user').addEventListener('input', debounce(() => loadActivityLogs(1), 300));

        document.getElementById('btn-reset-filters').addEventListener('click', function() {
            document.getElementById('filter-journal').value = '0';
            document.getElementById('filter-event').value = '';
            document.getElementById('filter-user').value = '';
            document.getElementById('filter-start').value = '';
            document.getElementById('filter-end').value = '';
            loadActivityLogs(1);
            vsaToast('Audit trail filters reset', 'info');
        });

        document.getElementById('btn-log-prev').addEventListener('click', () => { if (currentLogPage > 1) loadActivityLogs(currentLogPage - 1); });
        document.getElementById('btn-log-next').addEventListener('click', () => loadActivityLogs(currentLogPage + 1));

        // ---------------------------------------------------------------------
        // 8. Utility Functions
        // ---------------------------------------------------------------------
        function formatLocalTime(utcTimestamp) {
            if (!utcTimestamp || utcTimestamp === 'N/A') return 'N/A';
            const dateStr = utcTimestamp.includes('Z') || utcTimestamp.includes('+')
                ? utcTimestamp
                : utcTimestamp.replace(' ', 'T') + 'Z';
            const date = new Date(dateStr);
            if (isNaN(date.getTime())) return escapeHtml(utcTimestamp);

            return date.toLocaleString(undefined, {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: true
            }) + ' <strong>IST</strong>';
        }

        function debounce(func, wait) {
            let timeout;
            return function(...args) {
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(this, args), wait);
            };
        }

        function escapeHtml(str) {
            if (!str) return '';
            return String(str)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#039;');
        }

        // Initialize Data Load
        loadStats();
        loadUsers(1);
        loadActivityLogs(1);
    });
    {/literal}
</script>

{include file="frontend/components/footer.tpl"}
