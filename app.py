from flask import Flask, render_template_string
import json

app = Flask(__name__)

TEMPLATE = """
<!DOCTYPE html>
<html>
<head><title>SecureAD Sentinel</title>
<style>
  body{font-family:sans-serif;padding:2rem;background:#f5f5f5}
  h1{color:#333}
  .HIGH{background:#FCEBEB;border-left:4px solid #E24B4A;padding:10px 14px;margin:8px 0;border-radius:4px}
  .MEDIUM{background:#FAEEDA;border-left:4px solid #EF9F27;padding:10px 14px;margin:8px 0;border-radius:4px}
  .LOW{background:#EAF3DE;border-left:4px solid #639922;padding:10px 14px;margin:8px 0;border-radius:4px}
  .summary{background:white;padding:1rem;border-radius:6px;margin-bottom:1.5rem;border:1px solid #ddd}
</style>
</head>
<body>
<h1>SecureAD Sentinel Dashboard</h1>
<div class="summary">
  <strong>Domain:</strong> {{ report.domain }}<br>
  <strong>Scan Time:</strong> {{ report.timestamp }}<br>
  <strong>Total Findings:</strong> {{ report.total_findings }}
</div>
{% for f in report.findings %}
<div class="{{ f.severity }}">
  <strong>[{{ f.severity }}] {{ f.check }}</strong><br>
  Account: {{ f.get('account','N/A') }}<br>
  Remediation: {{ f.remediation }}
</div>
{% endfor %}
</body>
</html>
"""

@app.route("/")
def index():
    with open("ad_audit_report.json") as f:
        report = json.load(f)
    return render_template_string(TEMPLATE, report=report)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)