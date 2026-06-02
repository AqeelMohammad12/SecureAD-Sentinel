# AD-HealthReport.ps1

Write-Host "=== Generating AD Health Report ===" -ForegroundColor Cyan

$report = @()

# Check 1: Disabled accounts
$disabled = Get-ADUser -Filter {Enabled -eq $false} | Select-Object SamAccountName
$report += "--- Disabled Accounts ($($disabled.Count)) ---"
$disabled | ForEach-Object { $report += "  $($_.SamAccountName)" }

# Check 2: Password never expires
$neverExpires = Get-ADUser -Filter {PasswordNeverExpires -eq $true} -Properties PasswordNeverExpires | Select-Object SamAccountName
$report += ""
$report += "--- Password Never Expires ($($neverExpires.Count)) ---"
$neverExpires | ForEach-Object { $report += "  $($_.SamAccountName)" }

# Check 3: Kerberoastable accounts
$kerberoastable = Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName | Select-Object SamAccountName
$report += ""
$report += "--- Kerberoastable Accounts ($($kerberoastable.Count)) ---"
$kerberoastable | ForEach-Object { $report += "  $($_.SamAccountName) - $($_.ServicePrincipalName)" }

# Check 4: Domain Admins
$domainAdmins = Get-ADGroupMember "Domain Admins" | Select-Object SamAccountName
$report += ""
$report += "--- Domain Admins ($($domainAdmins.Count)) ---"
$domainAdmins | ForEach-Object { $report += "  $($_.SamAccountName)" }

# Check 5: Total user count
$totalUsers = (Get-ADUser -Filter *).Count
$report += ""
$report += "--- Total Users: $totalUsers ---"

# Output to screen
$report | ForEach-Object { Write-Host $_ }

# Save to file
$outputPath = "C:\HelpdeskSuite\ADHealthReport-$(Get-Date -Format 'yyyyMMdd').txt"
$report | Out-File $outputPath
Write-Host ""
Write-Host "Report saved to $outputPath" -ForegroundColor Green