# Offboard-User.ps1

Write-Host "=== Offboard User ===" -ForegroundColor Cyan

$username = Read-Host "Enter username to offboard"

# Check user exists
$user = Get-ADUser -Identity $username -ErrorAction SilentlyContinue
if (-not $user) {
    Write-Host "User $username not found." -ForegroundColor Red
    exit
}

# Disable the account
Disable-ADAccount -Identity $username
Write-Host "Account disabled." -ForegroundColor Yellow

# Move to a Disabled OU (uses default Users container)
$disabledOU = "CN=Users,DC=sentinel,DC=local"
Move-ADObject -Identity $user.DistinguishedName -TargetPath $disabledOU
Write-Host "Account moved to Users container." -ForegroundColor Yellow

# Remove from all groups except Domain Users
$groups = Get-ADPrincipalGroupMembership $username | 
    Where-Object {$_.Name -ne "Domain Users"}
foreach ($group in $groups) {
    Remove-ADGroupMember -Identity $group -Members $username -Confirm:$false
    Write-Host "Removed from group: $($group.Name)" -ForegroundColor Yellow
}

# Reset password to random value
$newPass = ConvertTo-SecureString "Disabled@$(Get-Random -Minimum 1000 -Maximum 9999)!" -AsPlainText -Force
Set-ADAccountPassword -Identity $username -NewPassword $newPass -Reset

Write-Host ""
Write-Host "User $username offboarded successfully." -ForegroundColor Green