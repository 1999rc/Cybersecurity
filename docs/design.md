System Design -
Cybersecurity Project 

# 1. Overview 

This project focuses on building a 
lightweight cybersecurity monitoring and 
hygien toolkit using Linux shell scripts and 
secure development practices.The goal is to
demonstrate real-world DevOps 
concetps such as logging,monitoring,
pre-commit security checks,and 
reproducible setup.

The system is intentionally simple,
transparent,and audible--designed for
learning and extention rather than black-box
automation.


# 2. 

* Monitor basic system activity and health 
  signals

* Maintain structured logs for auditing and 
  troubleshooting 

* Enforce security checks before code is 
  commited 

* Follow clean Git workflows and release
  practices 

* keep the tooclchain dependency-light 
  (mostly Bash)


# 3.Repository Structure 

Cybersecurity/
|---docs/
|  |---design.md 

|---logs/
|  |---system.log
|  |---system_YYYY-MM-DD.log 
|
|---scripts/
|  |---install.sh
|---src/
|  |---monitor.sh
|---.gitigonre
|---.pre-commit-config.yaml 
|---README.md

# 4. Core Concepts

# 4.1 Montoring Script(src/monitor.sh)

#Responsibilties:

* Collect basic system metrics (uptime,disk
  usage,memory,running processes)

## System Monitoring Script Design 

### Overview 
This project includes a unified Bash-based system
monitoring script 
('scr/monitor.sh') designed to run Linux,WSL,
and macOS (future-ready).

The script collects system health metrics and 
writes them to a daily
timestamped log file.

---

### OS Detection 
At runtime,the script detects the operating
system using 'uname' and 
additional checks:

- **Linux**: Standard Linux distributios 
- **WSL**: Detected by checking '/proc/version'
for Microsoft signatures 
- **macOS**: Detected via 'uname -s=Darwin'

This allows OS-specific logic while keeping a single
script.

--- 

### Logging Architecture
- Logs are written to:
  '$HOME//logs/system_YYYY-MM-DD.log'
- Each log entry is timestamped
- No terminal output (silent by design)
- Safe for cron and backgroud execution

--- 

### Metrics Collected 
- Operating System & Kernil 
- CPU usage ('/proc/stat')
- Load avergae 
- Memory usage 
- Disk usage 
- Top CPU-consuming processes 

--- 

### Reliability & Safety 
- Usage 'set-euo pipefail' for strict error handling
- Defensive OS checks prevent unsupported 
command execution 
- Designed to fail fast and log errors clearly 

--- 

### Automation Readiness
The script is non-interactive and log-based,
making it suitable for:
- Cron jobs 
- Scheduled monitoring 
- Server environments

---


# 4.2 Logging (logs/)
### Log Retention
- Automation cleanup of log files older than 7 days 
- Prevents disk overuse 
- Cleanup executed during each monitoring run

* Centralized logging directory 

* Daily log rotation using date-based 
  filenames 

* Logs are excluded from Git tracking 
  via .gitignore 

# Security considerations:

* No secrets or credentials written to logs 

* Logs kept local by default 

# 4.3 installation Script(scrpts/install.sh)

# Responsibilities:

* Verify environment prerequisites 

* Set executable permissions 

* Optionally configure cron or systemd
  (featuer scope)

# 4.4 Pre-commit Security Hooks 

# Configured via.pre-commit-config.yaml:

* YAML validation 

* End-of-file fixes 

* Large file
