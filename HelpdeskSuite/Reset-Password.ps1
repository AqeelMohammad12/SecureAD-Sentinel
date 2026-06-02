# Reset-Password.ps1

Write-Host "=== Reset User Password ===" -ForegroundColor Cyan

$username = Read-Host "Enter username"

# Check user exists
$user = Get-ADUser -Identity $username -ErrorAction SilentlyContinue
if (-not $user) {
    Write-Host "User $username not found." -ForegroundColor Red
    exit
}

$newPassword = Read-Host "Enter new temporary password" -AsSecureString

Set-ADAccountPassword -Identity $username -NewPassword $newPassword -Reset
Set-ADUser -Identity $username -ChangePasswordAtLogon $true

Write-Host ""
Write-Host "Password reset successfully for $username." -ForegroundColor Green
Write-Host "User will be prompted to change password on next login." -ForegroundColor Green