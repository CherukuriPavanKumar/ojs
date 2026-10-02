# Veridica Academic Network & OJS Super Admin Oversight Panel
## Developer Handover & System Documentation

**Date**: October 02, 2026
**Project**: Veridica Open Journal Systems (OJS 3.5.0-5 Custom Build) & Super Admin Oversight Panel
**Status**: ✅ ALL PHASES COMPLETE

---

## 1. 🔑 Test Accounts & System Credentials

### Standard Test Accounts Matrix
All standard test accounts use the default password: **`Password123!`**

| Role | Username | Email | Password | Allowed Access |
| :--- | :--- | :--- | :--- | :--- |
| **Site Admin / Super Admin** | `superadmin` | `admin@veridica.com` | `admin12345` / `Password123!` | Full Site Admin & Super Admin Oversight Panel |
| **Journal Manager** | `manager1` | `manager@veridica.com` | `Password123!` | Journal Settings, Submissions, Users |
| **Editor** | `editor1` | `test.editor@veridica.com` | `Password123!` | Editorial Workflow, Review Assignments & Decisions |
| **Author** | `author1` | `test.author@veridica.com` | `Password123!` | Manuscript Submission & Author Revisions |
| **Reviewer** | `reviewer1` | `test.reviewer@veridica.com` | `Password123!` | Peer Review Assignments & Confirmations |
| **Copyeditor** | `copyeditor1` | `test.copyeditor@veridica.com` | `Password123!` | Copyediting Stage Assignments |
| **Layout Editor** | `layouteditor1` | `layouteditor@veridica.com` | `Password123!` | Layout Editing Stage |
| **Proofreader** | `proofreader1` | `proofreader@veridica.com` | `Password123!` | Production & Proofreading Stage |
| **Subscription Manager** | `submanager1` | `submanager@veridica.com` | `Password123!` | Subscriptions Management |
| **Reader** | `reader1` | `reader@veridica.com` | `Password123!` | Public Article Reading & Downloads |

---

## 2. 🌐 Environment & Infrastructure

### Service Endpoints & Ports

* **Main OJS Journal Frontend**: `http://veridica.local` (or `http://127.0.0.1:8000` for dev)
  * **Local Directory**: `/home/pavankumar/ojs-3.5.0-5`
  * **Web Server**: Apache2 (VirtualHost: `veridica.local`) or PHP built-in server
* **Super Admin Oversight Panel**: `http://veridica.local/index.php/veridica/superadmin`
  * Built natively into OJS — no separate Next.js service required.
* **Database Connection**:
  * **Engine**: MySQL 8.0 / MariaDB
  * **Database**: `ojs_dev`
  * **Socket**: `~/.local/run/ojs-mariadb.sock`
  * **Host/Port**: `127.0.0.1:3306`

### Starting the Application (Development)
```bash
# Terminal 1: Start MariaDB
mariadbd --datadir="$HOME/.local/share/ojs-mariadb" \
         --socket="$HOME/.local/run/ojs-mariadb.sock" \
         --port=3306 --bind-address=127.0.0.1

# Terminal 2: Start PHP Dev Server
cd /home/pavankumar/ojs-3.5.0-5
php -S 127.0.0.1:8000 -t .
```

---

## 3. 🏗️ Architecture & Component Overview

```
OJS Core (PHP) ──> MySQL/MariaDB
    │
    ├── plugins/generic/superAdmin/
    │       ├── SuperAdminPlugin.php       ← Event hook registrations
    │       ├── SuperAdminSchemaMigration.php ← DB schema
    │       ├── MfaHelper.php              ← Pure PHP TOTP engine (RFC 6238)
    │       └── pages/SuperAdminHandler.php ← Dashboard + MFA controller
    │
    └── tools/purgeOldIps.php             ← GDPR cron script
```

---

## 4. ✅ Verified Super Admin Event Hooks (Phase 1)

All **6 platform oversight event hooks** verified live:

| Hook Event | Trigger Condition | Status |
| :--- | :--- | :---: |
| `login` | User authenticates | ✅ Verified |
| `file_uploaded` | Manuscript file attached | ✅ Verified |
| `submission_submitted` | Submission completed | ✅ Verified |
| `review_assigned` | Reviewer assigned | ✅ Verified |
| `review_accepted` | Reviewer confirms | ✅ Verified |
| `decision_added` | Editorial decision recorded | ✅ Verified |

---

## 5. 🗄️ Database Schema

### `super_admin_activity_log` Table
```sql
CREATE TABLE `super_admin_activity_log` (
  `log_id`        bigint        NOT NULL AUTO_INCREMENT,
  `user_id`       bigint        DEFAULT NULL,
  `journal_id`    bigint        DEFAULT NULL,
  `event_type`    varchar(255)  NOT NULL,
  `event_detail`  longtext,
  `ip_address`    varchar(45)   DEFAULT NULL,  -- Purged after 30 days (GDPR)
  `created_at`    datetime      DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
);
```

### MFA-Related `user_settings` Keys

| setting_name | Purpose | Lifetime |
|---|---|---|
| `superAdminMfaSecret` | TOTP secret (base32) | Permanent until MFA reset |
| `superAdminMfaPendingSecret` | Temp secret during QR setup | Deleted on confirm |
| `superAdminMfaVerifiedAt` | Unix timestamp of last OTP verify | Expires after 1 hour |

---

## 6. 🔐 MFA Flow (Phase 4)

The Super Admin Panel is protected by **TOTP-based Two-Factor Authentication** (RFC 6238 — compatible with Google Authenticator and Authy).

**First login ever:**
1. Admin visits `/superadmin` → redirected to `/superadmin/mfaSetup`
2. Scans QR code with Authenticator app (or enters manual secret)
3. Enters 6-digit OTP to confirm → secret saved to DB

**Every subsequent login session:**
1. Admin visits `/superadmin` → redirected to `/superadmin/mfaVerify`
2. Enters 6-digit OTP → `superAdminMfaVerifiedAt` timestamp written to DB
3. Dashboard accessible for 1 hour before re-verification required

**Lost authenticator app?** Click "Reset MFA device" on the verify page — this clears all MFA state and forces re-registration.

---

## 7. ⏰ GDPR Data Retention Cron

A cron job runs daily at 03:00 AM to purge IP addresses older than 30 days:

```
# Registered in crontab:
0 3 * * * php /home/pavankumar/ojs-3.5.0-5/tools/purgeOldIps.php >> /home/pavankumar/ojs-3.5.0-5/logs/gdpr-purge.log 2>&1
```

**To run manually:**
```bash
php /home/pavankumar/ojs-3.5.0-5/tools/purgeOldIps.php
```

---

## 8. 📦 Complete Phase-Wise Delivery Checklist

| Phase | Deliverable | Status |
|---|---|---|
| **Phase 1** | 6 event hooks + `super_admin_activity_log` schema | ✅ Done |
| **Phase 2** | Super Admin Dashboard UI (metrics, logs, user mgmt, CSV export) | ✅ Done |
| **Phase 3** | SMTP config, OAI-PMH, ORCID (native), Crossref/DOI, PKP PN, Languages | ✅ Done |
| **Phase 4** | TOTP MFA (QR setup + per-session verify) + GDPR IP purge cron | ✅ Done |
| **Phase 5** | Mobile responsive CSS, E2E QA (all 6 hooks verified), cron registered | ✅ Done |

---

## 9. 📌 Important Notes for Future Developers

1. **Do NOT modify `lib/pkp/` core files** beyond the two approved patches (`Locale.php` for PHP 8.5, `PKPTemplateManager.php` for sidebar link).
2. **MFA uses DB-backed state** — OJS's session handler drops raw `$_SESSION` writes between redirects. All MFA flags live in `user_settings`.
3. **SMTP credentials** are in `config.inc.php` (gitignored) — update with real credentials before production deployment.
4. **Plugin is always-on** — `getEnabled()` returns `true` unconditionally so it does not appear in the OJS plugin gallery UI.
