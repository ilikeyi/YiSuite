<#
	.Prerequisite
	.先决条件
#>
Function Prerequisite
{
	Clear-Host
	$Host.UI.RawUI.WindowTitle = "$($Global:Author)'s Solutions | $($lang.Prerequisites)"
	Write-Host "`n   $($lang.Prerequisites)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "   $($lang.Check_PSVersion): " -NoNewline
	if ($PSVersionTable.PSVersion.major -ge "5") {
		Write-host " $($lang.Check_Pass) " -BackgroundColor DarkGreen -ForegroundColor White
	} else {
		Write-host " $($lang.Failed) " -BackgroundColor DarkRed -ForegroundColor White

		Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		Write-host "     1. $($lang.UpdatePSVersion)`n"
		pause
		exit
	}

	Write-Host "   $($lang.Check_OSVersion): " -NoNewline
	$OSVer = [System.Environment]::OSVersion.Version;
	if (($OSVer.Major -eq 10 -and $OSVer.Minor -eq 0 -and $OSVer.Build -ge 16299)) {
		Write-host " $($lang.Check_Pass) " -BackgroundColor DarkGreen -ForegroundColor White
	} else {
		Write-host " $($lang.Failed) " -BackgroundColor DarkRed -ForegroundColor White

		Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		Write-host "    $($lang.UpdateOSVersion)`n"
		pause
		exit
	}

	Write-Host "   $($lang.Check_Higher_elevated): " -NoNewline
	if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
		Write-host " $($lang.Check_Pass) " -BackgroundColor DarkGreen -ForegroundColor White

		Write-Host "   $($lang.Check_execution_strategy): " -NoNewline
		switch (Get-ExecutionPolicy) {
			"Bypass" {
				Write-host " $($lang.Check_Pass) " -BackgroundColor DarkGreen -ForegroundColor White
			}
			"RemoteSigned" {
				Write-host " $($lang.Check_Pass) " -BackgroundColor DarkGreen -ForegroundColor White
			}
			"Unrestricted" {
				Write-host " $($lang.Check_Pass) " -BackgroundColor DarkGreen -ForegroundColor White
			}
			default {
				Write-host " $($lang.Check_Did_not_pass) " -BackgroundColor DarkRed -ForegroundColor White
	
				Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				Write-host "    $($lang.HigherTermail)`n"
				pause
				exit
			}
		}
	} else {
		Write-host " $($lang.Failed) " -BackgroundColor DarkRed -ForegroundColor White

		Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		Write-host "     $($lang.HigherTermailAdmin)`n"
		pause
		exit
	}

	Write-Host "`n   $($lang.Check_Pass_Done)" -ForegroundColor Green
	Start-Sleep -s 2
}