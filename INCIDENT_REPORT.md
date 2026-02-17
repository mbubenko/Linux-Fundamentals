# 📉 Incident After Action Report: Database Connection Failure

**Date:** Feb 17, 2026  
**Severity:** High (Production Outage)  
**Author:** Michael Bubenko, Senior ISSE  
**Status:** Resolved ✅

## 1. Issue Summary
At 09:00 AM, the application service reported a "503 Service Unavailable" error. Users were unable to access the frontend. Preliminary investigation pointed to a backend connectivity issue with the PostgreSQL database.

## 2. Root Cause Analysis (RCA)
The application was configured to connect to the database on **Port 5433**, but the database service was listening on the default **Port 5432**.
* **Contributing Factor:** A recent configuration deployment (`db.conf`) contained the incorrect port.
* **Contributing Factor:** The configuration file permissions were set to `400` (Read-Only), preventing immediate remediation by the operations team.

## 3. Timeline of Events
* **09:05:** Incident detected via application logs (`/var/log/app_errors.log`).
* **09:10:** `grep` analysis confirmed "Connection Refused" errors.
* **09:15:** `curl` test against localhost:5432 confirmed DB was healthy, indicating a config mismatch.
* **09:20:** Attempted to edit `db.conf` but failed due to permission denied.
* **09:25:** Escalated privileges via `chmod 600`, corrected port to 5432, and restored permissions.
* **09:30:** Service restarted and connectivity verified.

## 4. Lessons Learned & Action Items
* [ ] **Validation:** Implement a pre-deployment script to validate config ports against active services.
* [ ] **Automation:** Create an Ansible playbook to manage `db.conf` consistency to prevent manual drift.
