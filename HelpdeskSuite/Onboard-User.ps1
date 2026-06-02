# Onboard-User.ps1

Write-Host "=== Onboard New User ===" -ForegroundColor Cyan

$firstName  = Read-Host "First name"
$lastName   = Read-Host "Last name"
$department = Read-Host "Department"
$password   = Read-Host "Temporary password" -AsSecureString

$username   = ($firstName[0] + $lastName).ToLower()
$fullName   = "$firstName $lastName"

New-ADUser `
  -Name $fullName `
  -SamAccountName $username `
  -GivenName $firstName `
  -Surname $lastName `
  -Department $department `
  -Path "CN=Users,DC=sentinel,DC=local" `
  -AccountPassword $password `
  -ChangePasswordAtLogon $true `
  -Enabled $true

Write-Host ""
Write-Host "User $username created successfully." -ForegroundColor Green
Write-Host "They will be prompted to change password on first login." -ForegroundColor Green