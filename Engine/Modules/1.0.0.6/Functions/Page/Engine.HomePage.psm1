<#
	.LOGO
#>
Function Logo
{
	param
	(
		$Title
	)
	Clear-Host
	$Host.UI.RawUI.WindowTitle = "$((Get-Module -Name Engine).Author)'s Solutions | $($Title)"
	Write-Host "`n   Author: $((Get-Module -Name Engine).Author) ( $((Get-Module -Name Engine).HelpInfoURI) )

   From: $((Get-Module -Name Engine).Author)'s Solutions
   buildstring: $((Get-Module -Name Engine).Version.ToString()).bs_release.2024.12.08`n"
}

<#
	.返回到主界面
	.Return to the main interface
#>
Function ToMainpage
{
	param
	(
		[int]$wait
	)


	Write-Host $($lang.ToMsg -f $wait) -ForegroundColor Red
	Start-Sleep -s $wait
	Mainpage
}

Function Instl_Custom_Software_Config
{
	$DynamicInstl = "$($PSScriptRoot)\..\..\Instl\Instl.ps1"
	if (Test-Path $DynamicInstl -PathType Leaf) {
		$NewConfig = Join-Path -Path $(Convert-Path -Path "$($PSScriptRoot)\..\..") -ChildPath "langpacks\$($Global:IsLang)\App.json"

		if (Test-Path $NewConfig -PathType Leaf) {
			Start-Process powershell -ArgumentList "-File $($DynamicInstl) -Config ""$($NewConfig)"" -Lang ""$($Global:IsLang)""" -NoNewWindow -Wait
		} else {
			Write-Host "     $($lang.UpdateUnavailable)" -ForegroundColor Yellow
			Write-Host "     $($NewConfig)" -ForegroundColor Red
		}
	} else {
		Write-Host "`n   $($lang.InstlNo)$DynamicInstl" -ForegroundColor Red
	}
}

Function Instl_Custom_Software
{
	$DynamicInstl = "$($PSScriptRoot)\..\..\Instl\Instl.ps1"

	if (Test-Path $DynamicInstl -PathType Leaf) {
		Start-Process powershell -ArgumentList "-File $($DynamicInstl) -Lang ""$($Global:IsLang)""" -NoNewWindow -Wait
	} else {
		Write-Host "`n   $($lang.InstlNo)$DynamicInstl" -ForegroundColor Red
	}
}

<#
	.主界面
	.Main interface
#>
Function Mainpage
{
	Logo -Title $lang.Mainname
	Write-Host "   $($lang.Mainname)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	write-host "      1   $($lang.ChkUpdate)
      2   $($lang.FirstDeployment)
      3   $($lang.Delete) $($lang.Mainname)" -ForegroundColor Green

	write-host  "`n      4   $($lang.RestorePoint)
      5   $($lang.LocationUserFolder)
      6   $($lang.DeskIcon)
      7   $($lang.Optimize) $($lang.System)
      8   $($lang.Optimize) $($lang.Service)
      9   $($lang.Delete) $($lang.UninstallUWP)
     10   $($lang.Instl) $($lang.Necessary)
     11   $($lang.Instl) $($lang.MostUsedSoftware)`n"

	Write-Host "      C   $($lang.OnDemandPlanTask)" -ForegroundColor Green
	Write-host "      L   $($lang.SwitchLanguage)"
	Write-host "      R   $($lang.RefreshModules)`n"

	switch (Read-Host "   $($lang.PleaseChoose)")
	{
		"1" {
			Update
			Modules_Refresh -Function "ToMainpage -wait 2"
		}
		"2" {
			FirstExperience
			ToMainpage -wait 2
		}
		"3" {
			Uninstall
			ToMainpage -wait 2
		}
		"4" {
			Restore_Point_Create_UI
			ToMainpage -wait 2
		}
		"c" {
			$Global:EventQueueMode = $True
			Image_Assign_Event_Master
			Event_Assign_Not_Allowed_UI
			$Global:EventQueueMode = $False

			ToMainpage -wait 4
		}
		"5" {
			Change_Location
			ToMainpage -wait 2
		}
		"6" {
			Desktop
			ToMainpage -wait 2
		}
		"7" {
			Optimization_System_UI
			ToMainpage -wait 2
		}
		"8" {
			Optimization_Service_UI
			ToMainpage -wait 2
		}
		"9" {
			UWP_Uninstall
			ToMainpage -wait 2
		}
		"10" {
			Instl_Custom_Software_Config
			ToMainpage -wait 2
		}
		"11" {
			Instl_Custom_Software
			ToMainpage -wait 2
		}
		"l" {
			Language -Reset
			Mainpage
		}
		"r" {
			Modules_Refresh -Function "ToMainpage -wait 2"
		}
		"q" {
			Modules_Import
			Stop-Process $PID
			exit
		}
		default { Mainpage }
	}
}