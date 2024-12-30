﻿@{
	RootModule        = 'Engine.psm1'
	ModuleVersion     = '1.0.0.8'
	GUID              = '76fa0b4c-1927-43a7-8130-89708620aae5'
	Author            = 'Yi'
	Copyright         = 'FengYi, Inc. All rights reserved.'
	Description       = ''
	PowerShellVersion = '5.1'
	NestedModules     = @()
	FunctionsToExport = '*'
	CmdletsToExport   = '*'
	VariablesToExport = '*'
	AliasesToExport   = '*'

	PrivateData = @{
		PSData = @{
			Tags         = @("Yi.Suite")
			LicenseUri   = 'https://opensource.org/license/mit'
			ProjectUri   = @(
				'https://github.com/ilikeyi/YiSuite'
			)
#			IconUri      = ''
#			ReleaseNotes = ''
			Buildstring    = 'bs_release.2024.12.08'
			MinimumVersion = '1.0.0.0'
			UpdateServer = @(
				"https://fengyi.tel/download/solutions/update/Yi.Suite/latest.json"
				"https://github.com/ilikeyi/YiSuite/raw/main/update/latest.json"
			)
		}
	}
	HelpInfoURI = 'https://fengyi.tel'
#	DefaultCommandPrefix = ''
}