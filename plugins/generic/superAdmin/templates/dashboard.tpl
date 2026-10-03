{include file="frontend/components/header.tpl" pageTitleTranslated="Veridica Super Admin Panel"}

<!-- Import Concept 1 Editorial Academic Fonts: Merriweather & Inter -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:ital,wght@0,400;0,700;1,300&display=swap" rel="stylesheet">

<div id="veridica-superadmin-root" class="pkp_page_content">

    <!-- Header Banner (Editorial Academic Oxford Style) -->
    <div class="vsa-header-card">
        <div class="vsa-header-brand">
            <span class="vsa-badge-brand">VERIDICA ACADEMIC GOVERNANCE</span>
            <h1 class="vsa-title">Super Admin Oversight Panel</h1>
            <p class="vsa-subtitle">Universal activity logging, cross-journal governance, and system-wide monitoring across all hosted journals.</p>
        </div>
        <div class="vsa-header-actions">
            <a href="{$superAdminUrl}/exportCSV" id="vsa-export-btn" class="vsa-btn vsa-btn-gold">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                Export Activity Log (CSV)
            </a>
        </div>
    </div>

    <!-- Overview Metrics Cards -->
    <div class="vsa-metrics-grid">
        <div class="vsa-card vsa-metric-card">
            <div class="vsa-metric-icon vsa-icon-blue">
                <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
            </div>
            <div class="vsa-metric-data">
                <div class="vsa-metric-val" id="stat-users">--</div>
                <div class="vsa-metric-lbl">Total Registered Users</div>
            </div>
        </div>

        <div class="vsa-card vsa-metric-card">
            <div class="vsa-metric-icon vsa-icon-amber">
                <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
            </div>
            <div class="vsa-metric-data">
                <div class="vsa-metric-val" id="stat-submissions">--</div>
                <div class="vsa-metric-lbl">Total Manuscripts</div>
            </div>
        </div>

        <div class="vsa-card vsa-metric-card">
            <div class="vsa-metric-icon vsa-icon-purple">
                <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"></path></svg>
            </div>
            <div class="vsa-metric-data">
                <div class="vsa-metric-val" id="stat-reviews">--</div>
                <div class="vsa-metric-lbl">Active Peer Reviews</div>
            </div>
        </div>

        <div class="vsa-card vsa-metric-card">
            <div class="vsa-metric-icon vsa-icon-emerald">
                <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
            </div>
            <div class="vsa-metric-data">
                <div class="vsa-metric-val" id="stat-journals">--</div>
                <div class="vsa-metric-lbl">Hosted Journals</div>
            </div>
        </div>
    </div>

    <!-- Navigation Tabs -->
    <div class="vsa-tabs-container">
        <button class="vsa-tab-btn active" data-tab="tab-activity">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"></path></svg>
            System Activity Log
        </button>
        <button class="vsa-tab-btn" data-tab="tab-users">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
            Cross-Journal User Directory
        </button>
    </div>

    <!-- TAB 1: System Activity Log -->
    <div id="tab-activity" class="vsa-tab-content active">
        <div class="vsa-card">
            <!-- Filter Toolbar -->
            <div class="vsa-toolbar">
                <div class="vsa-filter-group">
                    <label for="filter-journal">Journal:</label>
                    <select id="filter-journal" class="vsa-select">
                        <option value="0">All Hosted Journals</option>
                        {foreach from=$journals item=j}
                            <option value="{$j->journal_id}">{$j->name|escape} ({$j->path|escape})</option>
                        {/foreach}
                    </select>
                </div>

                <div class="vsa-filter-group">
                    <label for="filter-event">Event Type:</label>
                    <select id="filter-event" class="vsa-select">
                        <option value="">All Event Types</option>
                        <option value="login">User Login (login)</option>
                        <option value="submission_submitted">Manuscript Submission (submission_submitted)</option>
                        <option value="file_uploaded">File Uploaded (file_uploaded)</option>
                        <option value="decision_added">Editorial Decision (decision_added)</option>
                        <option value="review_assigned">Reviewer Assigned (review_assigned)</option>
                        <option value="review_accepted">Review Accepted (review_accepted)</option>
                        <option value="review_declined">Review Declined (review_declined)</option>
                        <option value="user_registered">User Registered (user_registered)</option>
                        <option value="submission_published">Article Published (submission_published)</option>
                        <option value="super_admin_action">Super Admin Action (super_admin_action)</option>
                    </select>
                </div>

                <div class="vsa-filter-group">
                    <label for="filter-user">Search User / IP:</label>
                    <input type="text" id="filter-user" class="vsa-input" placeholder="Username, email, IP..." />
                </div>

                <div class="vsa-filter-group">
                    <label for="filter-start">Start Date:</label>
                    <input type="date" id="filter-start" class="vsa-input" />
                </div>

                <div class="vsa-filter-group">
                    <label for="filter-end">End Date:</label>
                    <input type="date" id="filter-end" class="vsa-input" />
                </div>

                <button id="btn-reset-filters" class="vsa-btn vsa-btn-secondary">Reset</button>
            </div>

            <!-- Activity Log Table -->
            <div class="vsa-table-responsive">
                <table class="vsa-table" id="table-activity-log">
                    <thead>
                        <tr>
                            <th>Log ID</th>
                            <th title="Times shown in your local timezone (UTC+5:30 for IST)">TIMESTAMP (LOCAL TIME)</th>
                            <th>User</th>
                            <th>Journal</th>
                            <th>Event Type</th>
                            <th>IP Address</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody id="log-rows">
                        <tr><td colspan="7" class="vsa-loading">Loading activity log...</td></tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="vsa-pagination">
                <span id="log-count-info" class="vsa-page-info">Showing 0 logs</span>
                <div class="vsa-page-btns">
                    <button id="btn-log-prev" class="vsa-btn vsa-btn-sm" disabled>Previous</button>
                    <span id="log-page-num" class="vsa-page-curr">Page 1</span>
                    <button id="btn-log-next" class="vsa-btn vsa-btn-sm" disabled>Next</button>
                </div>
            </div>
        </div>
    </div>

    <!-- TAB 2: User Directory -->
    <div id="tab-users" class="vsa-tab-content">
        <div class="vsa-card">
            <!-- Search Toolbar -->
            <div class="vsa-toolbar">
                <div class="vsa-filter-group style-grow">
                    <input type="text" id="user-search-input" class="vsa-input" placeholder="Search by name, username, or email..." />
                </div>
                <button id="user-search-btn" class="vsa-btn vsa-btn-primary">Search Users</button>
            </div>

            <!-- Users Table -->
            <div class="vsa-table-responsive">
                <table class="vsa-table" id="table-user-directory">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User Name</th>
                            <th>Username / Email</th>
                            <th>Per-Journal Roles</th>
                            <th title="Times shown in your local timezone (UTC+5:30 for IST)">REGISTRATION DATE (LOCAL TIME)</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="user-rows">
                        <tr><td colspan="7" class="vsa-loading">Loading users directory...</td></tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="vsa-pagination">
                <span id="user-count-info" class="vsa-page-info">Showing 0 users</span>
                <div class="vsa-page-btns">
                    <button id="btn-user-prev" class="vsa-btn vsa-btn-sm" disabled>Previous</button>
                    <span id="user-page-num" class="vsa-page-curr">Page 1</span>
                    <button id="btn-user-next" class="vsa-btn vsa-btn-sm" disabled>Next</button>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- CSS Styling (Concept 1: Editorial Academic - Oxford/Nature Inspired) -->
<style>
#veridica-superadmin-root {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    color: #1E293B;
    max-width: 1400px;
    margin: 0 auto;
    padding: 24px 20px;
    background-color: #F7F5F0;
    min-height: 100vh;
}
.vsa-header-card {
    background: #0F172A;
    border: 1px solid #1E293B;
    color: #FFFFFF;
    padding: 32px 36px;
    border-radius: 8px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 12px rgba(15, 23, 42, 0.08);
    margin-bottom: 28px;
}
.vsa-badge-brand {
    background: #C9A84C;
    color: #0F172A;
    font-size: 11px;
    font-weight: 700;
    padding: 5px 12px;
    border-radius: 4px;
    letter-spacing: 1.2px;
    display: inline-block;
    margin-bottom: 10px;
    font-family: 'Inter', sans-serif;
}
.vsa-title {
    font-family: 'Merriweather', Georgia, serif;
    font-size: 28px;
    font-weight: 700;
    margin: 4px 0 8px 0;
    color: #FFFFFF;
    letter-spacing: -0.3px;
}
.vsa-subtitle {
    font-size: 14px;
    color: #94A3B8;
    margin: 0;
    font-family: 'Inter', sans-serif;
}
.vsa-metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 28px;
}
.vsa-card {
    background: #FFFFFF;
    border-radius: 8px;
    border: 1px solid #E2E8F0;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
    padding: 24px;
}
.vsa-metric-card {
    display: flex;
    align-items: center;
    gap: 18px;
    border-left: 4px solid #0F172A;
}
.vsa-metric-icon {
    width: 48px;
    height: 48px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}
.vsa-icon-blue { background: #F1F5F9; color: #0F172A; border: 1px solid #E2E8F0; }
.vsa-icon-amber { background: #FEF8EC; color: #C9A84C; border: 1px solid #F6E6C2; }
.vsa-icon-purple { background: #F8FAFC; color: #475569; border: 1px solid #E2E8F0; }
.vsa-icon-emerald { background: #F0FDF4; color: #166534; border: 1px solid #DCFCE7; }
.vsa-metric-val {
    font-family: 'Merriweather', Georgia, serif;
    font-size: 28px;
    font-weight: 700;
    color: #0F172A;
    line-height: 1.2;
}
.vsa-metric-lbl {
    font-size: 13px;
    font-weight: 600;
    color: #64748B;
    margin-top: 4px;
    font-family: 'Inter', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.vsa-tabs-container {
    display: flex;
    gap: 8px;
    margin-bottom: 20px;
    border-bottom: 2px solid #E2E8F0;
    padding-bottom: 0;
}
.vsa-tab-btn {
    background: transparent;
    border: none;
    padding: 12px 24px;
    font-size: 14px;
    font-weight: 600;
    color: #64748B;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    border-bottom: 3px solid transparent;
    transition: all 0.2s ease;
    font-family: 'Inter', sans-serif;
}
.vsa-tab-btn:hover { color: #0F172A; }
.vsa-tab-btn.active {
    color: #0F172A;
    border-bottom-color: #C9A84C;
    font-weight: 700;
}
.vsa-tab-content { display: none; }
.vsa-tab-content.active { display: block; }

.vsa-toolbar {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    align-items: flex-end;
    margin-bottom: 24px;
    padding-bottom: 20px;
    border-bottom: 1px solid #E2E8F0;
    background: #FAFAFA;
    padding: 18px;
    border-radius: 6px;
    border: 1px solid #F1F5F9;
}
.vsa-filter-group {
    display: flex;
    flex-direction: column;
    gap: 6px;
}
.vsa-filter-group.style-grow { flex-grow: 1; }
.vsa-filter-group label {
    font-size: 11px;
    font-weight: 700;
    color: #475569;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
.vsa-select, .vsa-input {
    padding: 9px 14px;
    border: 1px solid #CBD5E1;
    border-radius: 4px;
    font-size: 13px;
    color: #0F172A;
    background: #FFFFFF;
    outline: none;
    font-family: 'Inter', sans-serif;
}
.vsa-select:focus, .vsa-input:focus {
    border-color: #C9A84C;
    box-shadow: 0 0 0 2px rgba(201, 168, 76, 0.2);
}
.vsa-btn {
    padding: 10px 18px;
    font-size: 13px;
    font-weight: 600;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    font-family: 'Inter', sans-serif;
    transition: background 0.15s ease;
}
.vsa-btn-primary { background: #0F172A; color: #FFFFFF; }
.vsa-btn-primary:hover { background: #1E293B; }
.vsa-btn-gold { background: #C9A84C; color: #0F172A; font-weight: 700; }
.vsa-btn-gold:hover { background: #B48A3C; color: #FFFFFF; }
.vsa-btn-secondary { background: #E2E8F0; color: #334155; }
.vsa-btn-secondary:hover { background: #CBD5E1; }
.vsa-btn-sm { padding: 6px 12px; font-size: 12px; }
.vsa-btn-danger { background: #991B1B; color: #FFFFFF; }
.vsa-btn-danger:hover { background: #7F1D1D; }
.vsa-btn-success { background: #166534; color: #FFFFFF; }
.vsa-btn-success:hover { background: #14532D; }

.vsa-table-responsive { overflow-x: auto; }
.vsa-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    font-size: 13px;
    font-family: 'Inter', sans-serif;
}
.vsa-table th {
    background: #0F172A;
    color: #F8FAFC;
    font-weight: 600;
    font-size: 11px;
    letter-spacing: 0.6px;
    text-transform: uppercase;
    padding: 14px 16px;
    border-bottom: 2px solid #1E293B;
}
.vsa-table td {
    padding: 14px 16px;
    border-bottom: 1px solid #E2E8F0;
    color: #334155;
}
.vsa-table tr:hover td { background: #F8FAFC; }
.vsa-loading { text-align: center; color: #64748B; padding: 28px !important; font-family: 'Merriweather', serif; font-style: italic; }

.vsa-badge {
    padding: 4px 10px;
    border-radius: 3px;
    font-size: 11px;
    font-weight: 700;
    display: inline-block;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-family: 'Inter', sans-serif;
}
.vsa-badge-event { background: #F1F5F9; color: #334155; border: 1px solid #CBD5E1; }
.vsa-badge-login { background: #EFF6FF; color: #1E40AF; border: 1px solid #BFDBFE; }
.vsa-badge-submission { background: #FEF8EC; color: #92400E; border: 1px solid #FDE68A; }
.vsa-badge-decision { background: #FAF5FF; color: #6B21A8; border: 1px solid #E9D5FF; }
.vsa-badge-review { background: #EEF2FF; color: #3730A3; border: 1px solid #C7D2FE; }
.vsa-badge-admin { background: #FEF2F2; color: #991B1B; border: 1px solid #FECACA; }
.vsa-badge-active { background: #F0FDF4; color: #166534; border: 1px solid #BBF7D0; }
.vsa-badge-suspended { background: #FEF2F2; color: #991B1B; border: 1px solid #FECACA; }
.vsa-badge-role { background: #F8FAFC; color: #475569; border: 1px solid #CBD5E1; margin: 2px; }

.vsa-pagination {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
    padding-top: 16px;
    border-top: 1px solid #E2E8F0;
}
.vsa-page-info { font-size: 12px; color: #64748B; font-weight: 500; }
.vsa-page-curr { font-size: 13px; font-weight: 700; color: #0F172A; margin: 0 10px; }

/* ============================================================
   MOBILE RESPONSIVENESS
   ============================================================ */
@media (max-width: 900px) {
    .vsa-metrics-grid { grid-template-columns: repeat(2, 1fr); }
    .vsa-header-card { flex-direction: column; align-items: flex-start; gap: 16px; }
    .vsa-header-actions { width: 100%; }
    .vsa-btn { width: 100%; justify-content: center; }
    .vsa-toolbar { flex-wrap: wrap; gap: 12px; }
    .vsa-filter-group { flex: 1 1 calc(50% - 12px); min-width: 140px; }
}
@media (max-width: 600px) {
    .vsa-metrics-grid { grid-template-columns: 1fr 1fr; gap: 12px; }
    .vsa-metric-card { padding: 16px 14px; }
    .vsa-metric-val { font-size: 22px; }
    .vsa-metric-lbl { font-size: 11px; }
    .vsa-tabs-container { overflow-x: auto; -webkit-overflow-scrolling: touch; flex-wrap: nowrap; gap: 6px; }
    .vsa-tab-btn { white-space: nowrap; font-size: 13px; padding: 10px 16px; }
    .vsa-toolbar { flex-direction: column; }
    .vsa-filter-group { width: 100%; flex: unset; }
    .vsa-select, .vsa-input { width: 100%; box-sizing: border-box; }
    .vsa-table-wrap { overflow-x: auto; -webkit-overflow-scrolling: touch; }
    .vsa-table { min-width: 640px; }
    .vsa-title { font-size: 20px; }
    .vsa-subtitle { font-size: 13px; }
    .vsa-pagination { flex-direction: column; align-items: center; gap: 10px; text-align: center; }
}
@media (max-width: 400px) {
    .vsa-metrics-grid { grid-template-columns: 1fr; }
    #veridica-superadmin-root { padding: 12px 8px; }
}
</style>
@media (max-width: 400px) {
    .vsa-metrics-grid { grid-template-columns: 1fr; }
    #veridica-superadmin-root { padding: 8px; }
}
</style>

<!-- JavaScript Logic -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const superAdminUrl = "{$superAdminUrl}";
    {literal}
    let currentLogPage = 1;
    let currentUserPage = 1;

    // Tab switching logic
    document.querySelectorAll('.vsa-tab-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.vsa-tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.vsa-tab-content').forEach(c => c.classList.remove('active'));

            this.classList.add('active');
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Load initial data
    loadStats();
    loadActivityLogs(1);
    loadUsers(1);

    // Filter event handlers for logs
    document.getElementById('filter-journal').addEventListener('change', () => loadActivityLogs(1));
    document.getElementById('filter-event').addEventListener('change', () => loadActivityLogs(1));
    document.getElementById('filter-user').addEventListener('input', debounce(() => loadActivityLogs(1), 400));
    document.getElementById('filter-start').addEventListener('change', () => loadActivityLogs(1));
    document.getElementById('filter-end').addEventListener('change', () => loadActivityLogs(1));
    document.getElementById('btn-reset-filters').addEventListener('click', function() {
        document.getElementById('filter-journal').value = '0';
        document.getElementById('filter-event').value = '';
        document.getElementById('filter-user').value = '';
        document.getElementById('filter-start').value = '';
        document.getElementById('filter-end').value = '';
        loadActivityLogs(1);
    });

    // Pagination listeners
    document.getElementById('btn-log-prev').addEventListener('click', () => { if (currentLogPage > 1) loadActivityLogs(currentLogPage - 1); });
    document.getElementById('btn-log-next').addEventListener('click', () => loadActivityLogs(currentLogPage + 1));

    document.getElementById('user-search-btn').addEventListener('click', () => loadUsers(1));
    document.getElementById('user-search-input').addEventListener('keypress', (e) => { if (e.key === 'Enter') loadUsers(1); });
    document.getElementById('btn-user-prev').addEventListener('click', () => { if (currentUserPage > 1) loadUsers(currentUserPage - 1); });
    document.getElementById('btn-user-next').addEventListener('click', () => loadUsers(currentUserPage + 1));

    // Export CSV query building
    document.getElementById('vsa-export-btn').addEventListener('click', function(e) {
        e.preventDefault();
        const jId = document.getElementById('filter-journal').value;
        const eType = document.getElementById('filter-event').value;
        const uQuery = document.getElementById('filter-user').value;
        const dStart = document.getElementById('filter-start').value;
        const dEnd = document.getElementById('filter-end').value;

        const params = new URLSearchParams({
            journal_id: jId,
            event_type: eType,
            user_query: uQuery,
            date_start: dStart,
            date_end: dEnd
        });

        window.location.href = superAdminUrl + '/exportCSV?' + params.toString();
    });

    function loadStats() {
        fetch(superAdminUrl + '/getStats')
            .then(res => res.json())
            .then(data => {
                if (data.status && data.content) {
                    document.getElementById('stat-users').innerText = data.content.totalUsers.toLocaleString();
                    document.getElementById('stat-submissions').innerText = data.content.totalSubmissions.toLocaleString();
                    document.getElementById('stat-reviews').innerText = data.content.activeReviews.toLocaleString();
                    document.getElementById('stat-journals').innerText = data.content.totalJournals.toLocaleString();
                }
            }).catch(err => console.error('Error fetching stats:', err));
    }

    function loadActivityLogs(page) {
        currentLogPage = page;
        const rowsContainer = document.getElementById('log-rows');
        rowsContainer.innerHTML = '<tr><td colspan="7" class="vsa-loading">Loading activity logs...</td></tr>';

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
                    const logs = data.content.logs;
                    const totalCount = data.content.totalCount;
                    const totalPages = data.content.totalPages;

                    document.getElementById('log-count-info').innerText = `Showing ${logs.length} of ${totalCount} logs`;
                    document.getElementById('log-page-num').innerText = `Page ${page} of ${totalPages || 1}`;

                    document.getElementById('btn-log-prev').disabled = (page <= 1);
                    document.getElementById('btn-log-next').disabled = (page >= totalPages);

                    if (logs.length === 0) {
                        rowsContainer.innerHTML = '<tr><td colspan="7" class="vsa-loading">No activity logs found matching criteria.</td></tr>';
                        return;
                    }

                    rowsContainer.innerHTML = logs.map(l => {
                        const userDisplay = l.username ? `${escapeHtml(l.first_name || '')} ${escapeHtml(l.last_name || '')} (<strong>${escapeHtml(l.username)}</strong>)` : '<em>Guest/System</em>';
                        const journalDisplay = l.journal_name ? `${escapeHtml(l.journal_name)} (${escapeHtml(l.journal_path)})` : '<em>Global/Site</em>';
                        
                        let badgeClass = 'vsa-badge-event';
                        if (l.event_type === 'login') badgeClass = 'vsa-badge-login';
                        else if (l.event_type.includes('submission')) badgeClass = 'vsa-badge-submission';
                        else if (l.event_type.includes('decision')) badgeClass = 'vsa-badge-decision';
                        else if (l.event_type.includes('review')) badgeClass = 'vsa-badge-review';
                        else if (l.event_type.includes('admin')) badgeClass = 'vsa-badge-admin';

                        return `<tr>
                            <td>#${l.log_id}</td>
                            <td>${formatLocalTime(l.created_at)}</td>
                            <td>${userDisplay}</td>
                            <td>${journalDisplay}</td>
                            <td><span class="vsa-badge ${badgeClass}">${escapeHtml(l.event_type)}</span></td>
                            <td><code>${escapeHtml(l.ip_address || 'N/A')}</code></td>
                            <td><small>${escapeHtml(l.event_detail)}</small></td>
                        </tr>`;
                    }).join('');
                }
            }).catch(err => console.error('Error fetching logs:', err));
    }

    function formatLocalTime(utcTimestamp) {
        if (!utcTimestamp || utcTimestamp === 'N/A') return 'N/A';
        const dateStr = utcTimestamp.includes('Z') || utcTimestamp.includes('+')
            ? utcTimestamp
            : utcTimestamp.replace(' ', 'T') + 'Z';
        const date = new Date(dateStr);
        if (isNaN(date.getTime())) return escapeHtml(utcTimestamp);

        const tzName = Intl.DateTimeFormat().resolvedOptions().timeZone || 'UTC';
        const formatted = date.toLocaleString(undefined, {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: true
        });

        let tzAbbrev = 'IST';
        try {
            const parts = new Intl.DateTimeFormat('en-US', { timeZoneName: 'short' }).formatToParts(date);
            const tzPart = parts.find(p => p.type === 'timeZoneName');
            if (tzPart) tzAbbrev = tzPart.value;
        } catch (e) {}

        return `<span title="Times shown in your local timezone (${tzName})">${escapeHtml(formatted)} <strong>${escapeHtml(tzAbbrev)}</strong></span>`;
    }

    function loadUsers(page) {
        currentUserPage = page;
        const rowsContainer = document.getElementById('user-rows');
        rowsContainer.innerHTML = '<tr><td colspan="7" class="vsa-loading">Loading users directory...</td></tr>';

        const search = document.getElementById('user-search-input').value;
        const params = new URLSearchParams({ page: page, search: search });

        fetch(superAdminUrl + '/getUsers?' + params.toString())
            .then(res => res.json())
            .then(data => {
                if (data.status && data.content) {
                    const users = data.content.users;
                    const totalCount = data.content.totalCount;
                    const totalPages = data.content.totalPages;

                    document.getElementById('user-count-info').innerText = `Showing ${users.length} of ${totalCount} registered users`;
                    document.getElementById('user-page-num').innerText = `Page ${page} of ${totalPages || 1}`;

                    document.getElementById('btn-user-prev').disabled = (page <= 1);
                    document.getElementById('btn-user-next').disabled = (page >= totalPages);

                    if (users.length === 0) {
                        rowsContainer.innerHTML = '<tr><td colspan="7" class="vsa-loading">No user accounts found matching query.</td></tr>';
                        return;
                    }

                    rowsContainer.innerHTML = users.map(u => {
                        const statusBadge = u.disabled == 1
                            ? '<span class="vsa-badge vsa-badge-suspended">Suspended</span>'
                            : '<span class="vsa-badge vsa-badge-active">Active</span>';

                        const actionBtn = u.disabled == 1
                            ? `<button class="vsa-btn vsa-btn-sm vsa-btn-success" onclick="toggleUser(${u.user_id}, 'reinstate')">Reinstate</button>`
                            : `<button class="vsa-btn vsa-btn-sm vsa-btn-danger" onclick="toggleUser(${u.user_id}, 'suspend')">Suspend</button>`;

                        const rolesHtml = (u.roles && u.roles.length > 0)
                            ? u.roles.map(r => `<span class="vsa-badge vsa-badge-role">${escapeHtml(r.role_name || 'Role #' + r.role_id)} (${escapeHtml(r.journal_name || 'Global')})</span>`).join(' ')
                            : '<em>No roles assigned</em>';

                        return `<tr>
                            <td>#${u.user_id}</td>
                            <td><strong>${escapeHtml(u.first_name || '')} ${escapeHtml(u.last_name || '')}</strong></td>
                            <td>${escapeHtml(u.username)}<br/><small class="text-muted">${escapeHtml(u.email)}</small></td>
                            <td>${rolesHtml}</td>
                            <td>${formatLocalTime(u.date_registered)}</td>
                            <td>${statusBadge}</td>
                            <td>${actionBtn}</td>
                        </tr>`;
                    }).join('');
                }
            }).catch(err => console.error('Error loading users:', err));
    }

    window.toggleUser = function(userId, action) {
        if (!confirm(`Are you sure you want to ${action} this user account across all journals?`)) return;

        const params = new URLSearchParams({
            target_user_id: userId,
            action: action
        });

        fetch(superAdminUrl + '/toggleUserStatus', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
        })
        .then(res => res.json())
        .then(data => {
            if (data.status) {
                alert(data.content.message);
                loadUsers(currentUserPage);
                loadActivityLogs(1); // Refresh logs as audit action was recorded
            } else {
                alert('Error: ' + (data.content || 'Failed to toggle user status.'));
            }
        }).catch(err => alert('Network error toggling user status.'));
    };

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
});
    {/literal}
</script>

{include file="frontend/components/footer.tpl"}
