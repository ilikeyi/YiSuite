<#
	.Help
	.帮助
#>
Function Engine_Help
{
	Clear-Host
	Logo -Title $lang.Help

	Write-Host "   $($lang.Short_Cmd)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "     lang".PadRight(20) -NoNewline -ForegroundColor Yellow
	Write-host $lang.SwitchLanguage

	Write-Host "     lang {}".PadRight(20) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.SwitchLanguage), $($lang.LanguageCode) { " -NoNewline
	Write-host "lang zh-CN" -NoNewline -ForegroundColor Green
	Write-host " }"

	Write-host
	Write-host "     Update".PadRight(20) -NoNewline -ForegroundColor Yellow
	Write-host $lang.ChkUpdate

	Write-host "     Update -auto".PadRight(20) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.ChkUpdate), $($lang.UpdateSilent)"
}