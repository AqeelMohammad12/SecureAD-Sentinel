# SecureAD Sentinel

An Active Directory security audit and hardening lab built on Windows Server 2022.

## Overview
SecureAD Sentinel is a home lab project demonstrating enterprise Active Directory 
design, attack simulation, and security hardening. The project covers the full 
attack-defense lifecycle — building a domain, identifying vulnerabilities, and 
implementing remediations with measurable results.

## Tech Stack
- Windows Server 2022 — Domain Controller
- Windows 11 Enterprise — Domain-joined workstation
- PowerShell — AD enumeration and hardening
- Python + Flask — Custom LDAP audit framework and dashboard
- PingCastle — AD risk assessment
- Group Policy — Security baseline enforcement

## Key Findings & Results
| Finding | Severity | Status |
|---|---|---|
| Kerberoastable service account (svc-sql) | HIGH | Remediated — replaced with gMSA |
| Password never expires (svc-sql) | MEDIUM | Remediated |
| Stale disabled account (old.contractor) | LOW | Remediated — deleted |
| Pass-the-Hash exposure | HIGH | Remediated — Protected Users enforced |

## PingCastle Risk Score
| | Score |
|---|---|
| Before hardening | 70/100 |
| After hardening | 45/100 |
| Risk reduction | 36% |

## Project Structure
- `ad_audit.py` — Python LDAP audit script
- `app.py` — Flask dashboard
- `ad_audit_report.json` — Sample audit report output

## Skills Demonstrated
Active Directory, Windows Server 2022, PowerShell, Python, Flask, LDAP, 
Group Policy, Kerberos, gMSA, PingCastle, NTLM, Security Hardening, 
CIS Benchmarks, Threat Detection, Vulnerability Remediation
