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
	Write-host "     Update         " -NoNewline -ForegroundColor Yellow
	Write-host $lang.ChkUpdate

	Write-host "     Update -auto   " -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.ChkUpdate), $($lang.UpdateSilent)"
}