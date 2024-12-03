<#
	.LOGO
#>
Function Logo
{
	param
	(
		$Title,
		[switch]$ShowUpdate
	)

	Clear-Host
	$Host.UI.RawUI.WindowTitle = "$($Global:Author)'s Solutions | $($Title)"

	Write-host
	Write-host "   " -NoNewline
	Write-Host " $($Global:Author)'s Solutions " -NoNewline -BackgroundColor White -ForegroundColor Black
	Write-host " v$((Get-Module -Name Engine).Version.ToString()) " -NoNewline -BackgroundColor DarkGreen -ForegroundColor White

	if ($ShowUpdate) {
		Write-host " $($lang.ChkUpdate) " -NoNewline -BackgroundColor White -ForegroundColor Black
		Write-host " Update " -BackgroundColor DarkMagenta -ForegroundColor White
	} else {
		Write-host
	}

	Write-host "   " -NoNewline
	Write-host " $($lang.Learn) " -NoNewline -BackgroundColor White -ForegroundColor Black
	Write-host " $((Get-Module -Name Engine).PrivateData.PSData.ProjectUri) " -BackgroundColor DarkBlue -ForegroundColor White

	Write-host
}

<#
	.返回到主界面
	.Return to the main interface
#>
Function ToMainpage
{
	param
	(
		[int]$Wait
	)

	Write-Host "   $($lang.ToMsg -f $wait)" -ForegroundColor Red
	start-process "timeout.exe" -argumentlist "/t $($wait) /nobreak" -wait -nonewwindow
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
	Logo -Title $lang.Mainname -ShowUpdate
	Write-Host "   $($lang.Mainname)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	write-host "      1   $($lang.ChkUpdate)" -ForegroundColor Green
	write-host "      2   $($lang.FirstDeployment)" -ForegroundColor Green
	write-host "      3   $($lang.Delete) $($lang.Mainname)" -ForegroundColor Green

	write-host "`n      4   $($lang.RestorePoint)" -ForegroundColor Green
	write-host "      5   $($lang.LocationUserFolder)" -ForegroundColor Green
	write-host "      6   $($lang.DeskIcon)" -ForegroundColor Green
	write-host "      7   $($lang.Optimize) $($lang.System)" -ForegroundColor Green
	write-host "      8   $($lang.Optimize) $($lang.Service)" -ForegroundColor Green
	write-host "      9   $($lang.Delete) $($lang.UninstallUWP)" -ForegroundColor Green
	write-host "     10   $($lang.Instl) $($lang.Necessary)" -ForegroundColor Green
	write-host "     11   $($lang.Instl) $($lang.MostUsedSoftware)"

	Write-Host "`n      C   $($lang.OnDemandPlanTask)" -ForegroundColor Green

	Write-Host "`n      L   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.SwitchLanguage

	Write-Host "      R   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.RefreshModules

	Write-host
	Write-host "   " -NoNewline
	Write-host " H " -NoNewline -BackgroundColor DarkMagenta -ForegroundColor White
	Write-host " $($lang.Help) " -NoNewline -BackgroundColor White -ForegroundColor Black
	Write-host " " -NoNewline
	switch -Wildcard (Read-Host $lang.PleaseChooseMain)
	{
		"update" {
			Update
			Modules_Refresh -Function "ToMainpage -wait 2", "Mainpage"
		}
		"update *" {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			$NewType = $PSItem.ToLower().replace('update','').replace(' ', '')
			switch ($NewType) {
				"-auto" {
					Update -Auto
				}
				default {
					Update
				}
			}

			Modules_Refresh -Function "ToMainpage -wait 2", "Mainpage"
		}
		"1" {
			Update
			Modules_Refresh -Function "ToMainpage -wait 2", "Mainpage"
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

			ToMainpage -wait 2
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
		"lang" {
			Language -Reset
			ToMainpage -wait 2
			Mainpage
		}
		"lang *" {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			$NewLanguage = $PSItem.ToLower().replace('lang','').replace(' ', '')
			Write-host "`n   $($lang.SwitchLanguage): " -NoNewline
			Write-host $NewLanguage -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path "$($PSScriptRoot)\..\..\langpacks\$($NewLanguage)\Lang.psd1" -PathType Leaf) {
				Write-Host "   $($lang.Done)" -ForegroundColor Green
				Save_Dynamic -regkey "Suite" -name "Language" -value $NewLanguage -String
				Modules_Refresh -Function "Language -Auto"
			} else {
				Write-Host "   $($lang.UpdateUnavailable)" -ForegroundColor Red
			}

			ToMainpage -wait 2
			Mainpage
		}
		"r" {
			Modules_Refresh -Function "ToMainpage -wait 2", "Mainpage"
		}
		"h" {
			Engine_Help
			Get_Next
			ToMainpage -wait 2
			Mainpage
		}
		"q" {
			return
		}
		default { Mainpage }
	}
}