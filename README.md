# Linux Application Troubleshooting & System Hardening 🐧

**Project Status:** ✅ Completed  
**Role:** Systems Engineer / Analyst  
**Environment:** Linux (Containerized), PostgreSQL, Bash

### 📋 Executive Summary
This project simulates a real-world production incident where a deployed application lost connectivity to its backend database. The objective was to utilize standard Linux CLI tools to diagnose the root cause, identifying configuration drift and permission errors without relying on GUI tools.

### 🔍 The Scenario
* **Issue:** Application reporting "Service Unavailable."
* **Investigation:** Initial checks confirmed the server was running, but application logs indicated connection failures.
* **Root Cause:** A configuration update pointed the application to the wrong database port (5433 instead of 5432), and the configuration file was locked (Read-Only) due to restrictive permissions.

### 🛠️ Technical Workflow & Remediation
I followed a structured troubleshooting methodology to restore service:

**1. Log Analysis & Discovery**
* Navigated the Linux file system (`cd`, `ls -l`, `pwd`) to locate application log directories.
* Utilized `grep` to filter thousands of log lines, isolating critical "Connection Refused" errors correlated with database requests.
* **Command Highlight:** `cat application.log | grep "Connection Refused" > db_errors.txt` (Data Redirection for evidence preservation).

**2. System Reconnaissance**
* Verified the status of the PostgreSQL database service using `curl` to query the local port, confirming the database was active on port `5432`.
* Located the misplaced configuration file using `find / -name "*.conf"`, revealing discrepancies between the active config and the backup.

**3. Remediation & Configuration Management**
* Identified that the configuration file `db.conf` had incorrect port settings.
* Attempted to edit the file using `vim` but encountered "Read-Only" permission errors.
* **Privilege Escalation:** Modified file permissions using `chmod` to allow write access for the root user.
* Corrected the port assignment in `vim`, saved the configuration, and restored original file permissions to maintain security posture.

### 🧰 Key Tools Used
| Category | Commands |
| :--- | :--- |
| **Navigation** | `cd`, `ls`, `pwd` |
| **Analysis** | `grep`, `cat`, `head`, `tail` |
| **Network** | `curl` (Service validation) |
| **File Mgmt** | `cp`, `find`, `diff` |
| **Permissions** | `chmod` (User/Group/Other management) |
| **Editing** | `vim` |

### 🚀 Impact
Successfully restored application connectivity by diagnosing a port mismatch and resolving permission bottlenecks. This lab reinforced the importance of log forensics and the "Check, Verify, Fix" loop in systems administration.
