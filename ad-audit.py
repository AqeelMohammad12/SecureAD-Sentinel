from ldap3 import Server, Connection, ALL, SUBTREE
import json, datetime

DC_IP   = "192.168.56.10"
DOMAIN  = "DC=sentinel,DC=local"
USER    = "svc-audit@sentinel.local"
PASS    = 'Audit@2024!'

server = Server(DC_IP, get_info=ALL)
conn   = Connection(server, USER, PASS, auto_bind=True)

findings = []

def search(filt, attrs):
    conn.search(DOMAIN, filt, SUBTREE, attributes=attrs)
    return conn.entries

# Check 1: Kerberoastable accounts
for e in search("(&(servicePrincipalName=*)(!(objectClass=computer))(!(cn=krbtgt)))",
                ["sAMAccountName","servicePrincipalName"]):
    findings.append({
        "check": "kerberoastable_account",
        "severity": "HIGH",
        "account": str(e.sAMAccountName),
        "remediation": "Replace with Group Managed Service Account (gMSA)"
    })

# Check 2: Password never expires
for e in search("(&(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=65536))",
                ["sAMAccountName"]):
    findings.append({
        "check": "password_never_expires",
        "severity": "MEDIUM",
        "account": str(e.sAMAccountName),
        "remediation": "Enforce password expiry or use gMSA"
    })

# Check 3: Disabled stale accounts
for e in search("(&(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))",
                ["sAMAccountName"]):
    findings.append({
        "check": "disabled_stale_account",
        "severity": "LOW",
        "account": str(e.sAMAccountName),
        "remediation": "Delete or archive after 30 days"
    })

report = {
    "timestamp": datetime.datetime.utcnow().isoformat(),
    "domain": "sentinel.local",
    "total_findings": len(findings),
    "findings": findings
}

with open("ad_audit_report.json","w") as f:
    json.dump(report, f, indent=2)

print(f"[+] {len(findings)} findings written to ad_audit_report.json")