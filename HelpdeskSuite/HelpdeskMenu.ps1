# Helpdesk Automation Suite
# Main Menu

function Show-Menu {
    Clear-Host
    Write-Host "=============================" -ForegroundColor Cyan
    Write-Host "   Helpdesk Automation Suite  " -ForegroundColor Cyan
    Write-Host "=============================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Onboard New User"
    Write-Host "2. Offboard User"
    Write-Host "3. Reset User Password"
    Write-Host "4. Add/Remove User from Group"
    Write-Host "5. Generate AD Health Report"
    Write-Host "6. Exit"
    Write-Host ""
}

do {
    Show-Menu
    $choice = Read-Host "Select an option (1-6)"

    switch ($choice) {
        "1" { & "C:\HelpdeskSuite\Onboard-User.ps1" }
        "2" { & "C:\HelpdeskSuite\Offboard-User.ps1" }
        "3" { & "C:\HelpdeskSuite\Reset-Password.ps1" }
        "4" { & "C:\HelpdeskSuite\Manage-Groups.ps1" }
        "5" { & "C:\HelpdeskSuite\AD-HealthReport.ps1" }
        "6" { Write-Host "Exiting..." -ForegroundColor Yellow; exit }
        default { Write-Host "Invalid option. Try again." -ForegroundColor Red }
    }

    if ($choice -ne "6") {
        Write-Host ""
        Read-Host "Press Enter to return to menu"
    }

} while ($choice -ne "6")