# Manage-Groups.ps1

Write-Host "=== Add/Remove User from Group ===" -ForegroundColor Cyan

$username  = Read-Host "Enter username"
$groupName = Read-Host "Enter group name"

# Check user exists
$user = Get-ADUser -Identity $username -ErrorAction SilentlyContinue
if (-not $user) {
    Write-Host "User $username not found." -ForegroundColor Red
    exit
}

# Check group exists
$group = Get-ADGroup -Identity $groupName -ErrorAction SilentlyContinue
if (-not $group) {
    Write-Host "Group $groupName not found." -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "1. Add user to group"
Write-Host "2. Remove user from group"
$action = Read-Host "Select option (1-2)"

switch ($action) {
    "1" {
        Add-ADGroupMember -Identity $groupName -Members $username
        Write-Host ""
        Write-Host "$username added to $groupName successfully." -ForegroundColor Green
    }
    "2" {
        Remove-ADGroupMember -Identity $groupName -Members $username -Confirm:$false
        Write-Host ""
        Write-Host "$username removed from $groupName successfully." -ForegroundColor Green
    }
    default {
        Write-Host "Invalid option." -ForegroundColor Red
    }
}