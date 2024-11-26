<#
	.Summary
	 Yi's Solutions

	.PowerShell must be run with elevated privileges, run
	 powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"

	.Or run in a PowerShell session, PS C:\>
	 Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

	.EXAMPLE
	 PS C:\> .\_get.ps1                   | User interactive
	 PS C:\> .\_get.ps1 -Cus              | Any website connection, example: 
	                                        "https://fengyi.tel/latest.zip", "https://Github.com/latest.zip"

	 PS C:\> .\_get.ps1 -To               | Install to
											"AutoSelectDisk" = Automatically search available disks
											"Desktop"        = Current user desktop
											"Download"       = Current user downloads
											"Documents"      = Current user documents

	 PS C:\> .\_get.ps1 -GoTo             | After installation, go to
											"Main"           = Main Program
											"Upgrade"        = Creating an upgrade package
											"No"             = Do not go

	 PS C:\> .\_get.ps1 -Silent           | After customizing the interactive mode, you can add a silent installation command to perform the installation.

	.Learn
	 Interactive installation
	    https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Get/Get.pdf

	.LINK
	 https://github.com/ilikeyi/YiSuite

	.NOTES
	 Author:  Yi
	 Website: http://fengyi.tel
#>

[CmdletBinding()]
param
(
	[String]
	$Language,

	[String[]]
	$Cus,

	[String]
	$To,

	[String]
	$GoTo,

	[switch]
	$Silent
)

$Author = "Yi"
$Default_directory_name = "Yi.Suite"
$Update_Server = @(
	"https://fengyi.tel/download/solutions/update/Yi.Suite/latest.zip"
	"https://github.com/ilikeyi/YiSuite/raw/main/update/latest.zip"
)

<#
	.Language
#>
$Global:lang = @()
$Global:IsLang = ""
$AvailableLanguages = @(
	@{
		Tag      = "en-US"
		Name     = "English (United States)"
		Language = @{
			Get                     = "Get Yi's optimization script online"
			UpdateServerSelect      = "Automatic server selection or custom selection"
			UpdateServerNoSelect    = "Please select an available server"
			UpdatePriority          = "has been set as priority"
			UpdateServerTestFailed  = "Failed server status test"
			UpdateQueryingUpdate    = "Querying and updating..."
			UpdateQueryingTime      = "Checking if the latest version is available,`n   the connection took {0} milliseconds."
			UpdateConnectFailed     = "Unable to connect to the remote server, access to online has been aborted."
			UpdateCheckServerStatus = "Check server status ( total {0} optional )"
			UpdateServerAddress     = "Server address"
			UpdateServeravailable   = "Status: Available"
			UpdateServerUnavailable = "Status: Unavailable"
			InstlTo                 = "Install to, new name"
			SelectFolder            = "Select directory"
			OpenFolder              = "Open Directory"
			Paste                   = "Copy path"
			FailedCreateFolder      = "Failed to create directory"
			IsOldFile               = "Please delete the old file and try again"
			Restore                 = "Restore to default save path"
			RestoreTo               = "When restoring the saved path, automatically select"
			RestoreToDisk           = "Automatically select available disk"
			RestoreToDesktop        = "Desktop"
			RestoreToDownload       = "Download"
			RestoreToDocuments      = "Documents"
			FileName                = "File name"
			Done                    = "Done"
			Inoperable              = "Inoperable"
			FileFormatError         = "File format error."
			AdvOption               = "Optional function"
			Ok_Go_To                = "First visit to"
			Ok_Go_To_Main           = "Main Program"
			Ok_Go_To_No             = "Not going"
			OK_Go_To_Upgrade_package = "Creating an upgrade package"
			Unpacking               = "Unpacking"
			SaveTo                  = "Save to"
			OK                      = "OK"
			Cancel                  = "Cancel"
			UserCancel              = "The user has cancelled the operation."
			AllSel                  = "Select all"
			AllClear                = "Clear all"
		}
	}
)

Function Language
{
	$Global:lang = @()
	$Global:IsLang = ""
	$PrimaryLnguage = (Get-Culture).Name

	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq $PrimaryLnguage) {
			$Global:lang = $item.Language
			$Global:IsLang = $item.Tag
			return
		}
	}

	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq "en-US") {
			$Global:lang = $item.Language
			$Global:IsLang = $item.Tag
			return
		}
	}

	Write-Host "No language packs found, please try again." -ForegroundColor Red
	Start-Sleep -s 2
	exit
}

<#
	.Prerequisite
#>
Function Prerequisite
{
	Clear-Host
	$Host.UI.RawUI.WindowTitle = "$($lang.Get) | Prerequisites"
	Write-Host "`n   Prerequisites" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host -NoNewline "   Checking PS version 5.1 and above".PadRight(75)
	if ($PSVersionTable.PSVersion.major -ge "5") {
		Write-Host "OK".PadLeft(8) -ForegroundColor Green
	} else {
		Write-Host " Failed".PadLeft(8) -ForegroundColor Red

		Write-host "`n   How to solve: " -ForegroundColor Yellow
		Write-host "   $('-' * 80)"	
		Write-host "     1. Please install the latest PowerShell version`n"
		pause
		exit
	}

	Write-Host -NoNewline "   Checking Windows version > 10.0.16299.0".PadRight(75)
	$OSVer = [System.Environment]::OSVersion.Version;
	if (($OSVer.Major -eq 10 -and $OSVer.Minor -eq 0 -and $OSVer.Build -ge 16299)) {
		Write-Host "OK".PadLeft(8) -ForegroundColor Green
	} else {
		Write-Host "Failed".PadLeft(8) -ForegroundColor Red

		Write-host "`n   How to solve: " -ForegroundColor Yellow
		Write-host "   $('-' * 80)"	
		Write-host "     1. Go to the official Microsoft website to download the latest"
		Write-host "        version of the operating system "
		Write-host "`n     2. Install the latest version of the operating system and try again`n"
		pause
		exit
	}

	Write-Host -NoNewline "   Checking Must be elevated to higher authority".PadRight(75)
	if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
		Write-Host "OK".PadLeft(8) -ForegroundColor Green

		Write-Host -NoNewline "   Check execution strategy".PadRight(75)
		switch (Get-ExecutionPolicy) {
			"Bypass" {
				Write-Host "Pass".PadLeft(8) -ForegroundColor Green
			}
			"RemoteSigned" {
				Write-Host "Pass".PadLeft(8) -ForegroundColor Green
			}
			"Unrestricted" {
				Write-Host "Pass".PadLeft(8) -ForegroundColor Green
			}
			default {
				Write-Host "Did not pass".PadLeft(8) -ForegroundColor Red

				Write-host "`n   How to solve: " -ForegroundColor Yellow
				Write-host "   $('-' * 80)"	
				Write-host "     1. Open ""Terminal"" or ""PowerShell ISE"" as an administrator, "
				Write-host "        set PowerShell execution policy: Bypass, PS command line: `n"
				Write-host "        Set-ExecutionPolicy -ExecutionPolicy Bypass -Force" -ForegroundColor Green
				Write-host "`n     2. Once resolved, rerun the command`n"
				pause
				exit
			}
		}
	} else {
		Write-Host "Failed".PadLeft(8) -ForegroundColor Red

		Write-host "`n   How to solve: " -ForegroundColor Yellow
		Write-host "   $('-' * 80)"	
		Write-host "     1. Open ""Terminal"" or ""PowerShell ISE"" as an administrator."
		Write-host "`n     2. Once resolved, rerun the command`n"
		pause
		exit
	}

	Write-Host "`n   Congratulations, it has passed." -ForegroundColor Green
	Start-Sleep -s 2
}

<#
	.Dynamic save function
#>
Function Save_Dynamic
{
	param
	(
		$regkey,
		$name,
		$value,
		[switch]$Multi,
		[switch]$String
	)

	$Path = "HKCU:\SOFTWARE\$($Author)\$($regkey)"

	if (-not (Test-Path $Path)) {
		New-Item -Path $Path -Force -ErrorAction SilentlyContinue | Out-Null
	}

	if ($Multi) {
		New-ItemProperty -LiteralPath $Path -Name $name -Value $value -PropertyType MultiString -force -ErrorAction SilentlyContinue | Out-Null
	}
	if ($String) {
		New-ItemProperty -LiteralPath $Path -Name $name -Value $value -PropertyType String -force -ErrorAction SilentlyContinue | Out-Null
	}
}

Function Get_Arch_Path
{
	param
	(
		[string]$Path
	)

	switch ($env:PROCESSOR_ARCHITECTURE) {
		"arm64" {
			if (Test-Path -Path "$($Path)\$($arm64)" -PathType Container) {
				return Convert-Path -Path "$($Path)\$($arm64)" -ErrorAction SilentlyContinue
			}
		}
		"AMD64" {
			if (Test-Path -Path "$($Path)\$($AMD64)" -PathType Container) {
				return Convert-Path -Path "$($Path)\$($AMD64)" -ErrorAction SilentlyContinue
			}
		}
		"x86" {
			if (Test-Path -Path "$($Path)\$($x86)" -PathType Container) {
				return Convert-Path -Path "$($Path)\$($x86)" -ErrorAction SilentlyContinue
			}
		}
	}

	return $Path
}

Function Join_MainFolder
{
	param
	(
		[string]$Path
	)
	if ($Path.EndsWith('\'))
	{
		return $Path
	} else {
		return "$($Path)\"
	}
}

Function Get_Zip
{
	param
	(
		$Run
	)

	$Local_Zip_Path = @(
		"${env:ProgramFiles}\7-Zip\$($Run)"
		"${env:ProgramFiles(x86)}\7-Zip\$($Run)"
	)

	ForEach ($item in $Local_Zip_Path) {
		if (Test-Path -Path $item -PathType leaf) {
			return $item
		}
	}

	return $False
}

Function Archive
{
	param
	(
		$filename,
		$to
	)

	$filename = Convert-Path $filename -ErrorAction SilentlyContinue

	if (Test-Path -Path $to -PathType leaf) {
		$to = Convert-Path $to -ErrorAction SilentlyContinue
	}

	Write-Host "   $($lang.Filename): " -NoNewline -ForegroundColor Yellow
	Write-Host $filename -ForegroundColor Green

	Write-host "   $($lang.SaveTo): " -NoNewline -ForegroundColor Yellow
	Write-Host $to -ForegroundColor Green

	Write-Host "   $($lang.Unpacking)".PadRight(28) -NoNewline

	$Verify_Install_Path = Get_Zip -Run "7z.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$arguments = @(
			"x",
			"-r",
			"-tzip",
			"""$($filename)""",
			"-o""$($to)""",
			"-y";
		)

		Start-Process -FilePath $Verify_Install_Path -ArgumentList $Arguments -Wait -WindowStyle Minimized

		Write-Host "     $($lang.Done)`n" -ForegroundColor Green
	} else {
		Expand-Archive -LiteralPath $filename -DestinationPath $to -force
		Write-Host "     $($lang.Done)`n" -ForegroundColor Green
	}
}

Function TestArchive
{
	param
	(
		$Path
	)

	Add-Type -Assembly System.IO.Compression.FileSystem -ErrorAction Stop

	Try {
		$zipFile = [System.IO.Compression.ZipFile]::OpenRead($Path)
		Return $true
	} Catch {
		Return $false
	} Finally {
		If ($zipFile) {
			Try { $zipFile.Dispose() } Catch {}
		}
	}
}

Function Verify_Available_Size
{
	param
	(
		[string]$Disk,
		[int]$Size
	)

	$TempCheckVerify = $false

	Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | Where-Object { ((Join_MainFolder -Path $Disk) -eq $_.Root) } | ForEach-Object {
		if ($_.Free -gt (Convert_Size -From GB -To Bytes $Size)) {
			$TempCheckVerify = $True
		} else {
			$TempCheckVerify = $false
		}
	}

	return $TempCheckVerify
}

Function Convert_Size
{
	param
	(
		[validateset("Bytes","KB","MB","GB","TB")]
		[string]$From,
		[validateset("Bytes","KB","MB","GB","TB")]
		[string]$To,
		[Parameter(Mandatory=$true)]
		[double]$Value,
		[int]$Precision = 4
	)
	switch($From) {
		"Bytes" { $value = $Value }
		"KB" { $value = $Value * 1024 }
		"MB" { $value = $Value * 1024 * 1024 }
		"GB" { $value = $Value * 1024 * 1024 * 1024 }
		"TB" { $value = $Value * 1024 * 1024 * 1024 * 1024 }
	}
	switch ($To) {
		"Bytes" { return $value }
		"KB" { $Value = $Value/1KB }
		"MB" { $Value = $Value/1MB }
		"GB" { $Value = $Value/1GB }
		"TB" { $Value = $Value/1TB }
	}

	return [Math]::Round($value, $Precision, [MidPointRounding]::AwayFromZero)
}

Function Test_Available_Disk
{
	param
	(
		[string]$Path
	)

	try {
		New-Item -Path $Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

		$RandomGuid = [guid]::NewGuid()
		$test_tmp_filename = "writetest-$($RandomGuid)"
		$test_filename = Join-Path -Path $Path -ChildPath $test_tmp_filename -ErrorAction SilentlyContinue

		[io.file]::OpenWrite($test_filename).close()

		if (Test-Path $test_filename -PathType Leaf) {
			Remove-Item -Path $test_filename -ErrorAction SilentlyContinue
			return $true
		}
		$false
	} catch {
		return $false
	}
}

<#
	.Test if the URL address is available
#>
Function Test_URI
{
	Param
	(
		[Parameter(Position=0,Mandatory,HelpMessage="HTTP or HTTPS")]
		[ValidatePattern( "^(http|https)://" )]
		[Alias("url")]
		[string]$URI,
		[Parameter(ParameterSetName="Detail")]
		[Switch]$Detail,
		[ValidateScript({$_ -ge 0})]
		[int]$Timeout = 30
	)
	Process
	{
		Try
		{
			$paramHash = @{
				UseBasicParsing = $True
				DisableKeepAlive = $True
				Uri = $uri
				Method = 'Head'
				ErrorAction = 'stop'
				TimeoutSec = $Timeout
			}
			$test = Invoke-WebRequest @paramHash
			if ($Detail) {
				$test.BaseResponse | Select-Object ResponseURI,ContentLength,ContentType,LastModified, @{Name="Status";Expression={$Test.StatusCode}}
			} else {
				if ($test.statuscode -ne 200) { $False } else { $True }
			}
		} Catch {
			write-verbose -message $_.exception
			if ($Detail) {
				$objProp = [ordered]@{
					ResponseURI = $uri
					ContentLength = $null
					ContentType = $null
					LastModified = $null
					Status = 404
				}
				New-Object -TypeName psobject -Property $objProp
			} else { $False }
		}
	}
}

Function Installation_interface_UI
{
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	Write-Host "`n   $($lang.Get)"
	Write-Host "   $('-' * 80)"

	Function Install_Init_Disk_To
	{
		switch ($UI_Main_Install_To.SelectedItem.Path) {
			"AutoSelectDisk" {
				$drives = Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | Where-Object { -not ((Join_MainFolder -Path $env:SystemDrive) -eq $_.Root) } | Select-Object -ExpandProperty 'Root'
				$FlagsSearchNewDisk = $False
				ForEach ($item in $drives) {
					if (Test_Available_Disk -Path $item) {
						$FlagsSearchNewDisk = $True

						if (Verify_Available_Size -Disk $item -Size "1") {
							return $item
						}
					}
				}

				if (-not ($FlagsSearchNewDisk)) {
					return Join_MainFolder -Path $env:SystemDrive
				}
			}
			"Desktop" {
				return [Environment]::GetFolderPath("Desktop")
			}
			"Download" {
				return (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
			}
			"Documents" {
				return [Environment]::GetFolderPath("MyDocuments")
			}
			default {
				return (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
			}
		}
	}

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 550
		Text           = $lang.Get
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
		Font           = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
	}

	$UI_Main_Menu      = New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0 
		Height         = 565
		Width          = 505
		autoSizeMode   = 1
		Location       = '15,10'
		autoScroll     = $True
	}

	$UI_Main_Auto_Select = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 360
		Text           = $lang.UpdateServerSelect
		Checked        = $True
		add_Click      = {
			if ($UI_Main_Auto_Select.Checked) {
				$UI_Main_List.Enabled = $False
			} else {
				$UI_Main_List.Enabled = $True
			}
		}
	}
	$UI_Main_List      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		autosize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
		Padding        = "15,0,0,0"
		Enabled        = $False
	}

	$UI_Main_List_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 480
	}

	$UI_Main_Save_To   = New-Object System.Windows.Forms.Label -Property @{
		autoSize       = 1
		Margin         = "0,0,0,10"
		Text           = "$($lang.InstlTo): $($Default_directory_name)"
	}
	$UI_Main_Save_To_Path = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 435
		Margin         = "25,0,0,20"
		Text           = ""
		Enabled        = $False
	}

	$UI_Main_Save_To_SelectFolder = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 40
		Width          = 480
		Padding        = "20,0,5,0"
		Text           = $lang.SelectFolder
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""

			$FolderBrowser   = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
				RootFolder   = "MyComputer"
			}

			if ($FolderBrowser.ShowDialog() -eq "OK") {
				if (Test_Available_Disk -Path $FolderBrowser.SelectedPath) {
					$UI_Main_Save_To_Path.Text = Join-Path -Path $FolderBrowser.SelectedPath -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
					Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value $UI_Main_Save_To_Path.Text -String
				} else {
					$UI_Main_Error.Text = $lang.FailedCreateFolder
				}
			} else {
				$UI_Main_Error.Text = $lang.UserCancel
			}
		}
	}

	$UI_Main_Save_To_OpenFolder = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 40
		Width          = 480
		Padding        = "20,0,0,0"
		Text           = $lang.OpenFolder
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""

			if ([string]::IsNullOrEmpty($UI_Main_Save_To_Path.Text)) {
				$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
			} else {
				if (Test-Path -Path $UI_Main_Save_To_Path.Text -PathType Container) {
					Start-Process $UI_Main_Save_To_Path.Text

					$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
				} else {
					$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
				}
			}
		}
	}

	$UI_Main_Save_To_Paste = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 40
		Width          = 480
		Padding        = "20,0,0,0"
		Text           = $lang.Paste
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""

			if ([string]::IsNullOrEmpty($UI_Main_Save_To_Path.Text)) {
				$UI_Main_Error.Text = "$($lang.Paste), $($lang.Inoperable)"
			} else {
				Set-Clipboard -Value $UI_Main_Save_To_Path.Text

				$UI_Main_Error.Text = "$($lang.Paste), $($lang.Done)"
			}
		}
	}

	$UI_Main_Install_To_Name  = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 480
		Padding        = "22,0,0,0"
		Text           = $lang.RestoreTo
	}
	$UI_Main_Install_To = New-Object system.Windows.Forms.ComboBox -Property @{
		Height         = 30
		Width          = 420
		margin         = "40,0,0,20"
		Text           = ""
		DropDownStyle  = "DropDownList"
		add_Click      = {
			$UI_Main_Error.Text = ""
		}
	}

	$InstallToNew = [Collections.ArrayList]@(
		[pscustomobject]@{ Path = "AutoSelectDisk"; Lang = $lang.RestoreToDisk; }
		[pscustomobject]@{ Path = "Desktop";        Lang = $lang.RestoreToDesktop; }
		[pscustomobject]@{ Path = "Download";       Lang = $lang.RestoreToDownload; }
		[pscustomobject]@{ Path = "Documents";      Lang = $lang.RestoreToDocuments; }
	)

	$UI_Main_Install_To.BindingContext = New-Object System.Windows.Forms.BindingContext
	$UI_Main_Install_To.Datasource = $InstallToNew
	$UI_Main_Install_To.ValueMember = "Path"
	$UI_Main_Install_To.DisplayMember = "Lang"

	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Author)\Suite\Get" -Name "InstlTo" -ErrorAction SilentlyContinue) {
		$UI_Main_Save_To_Path.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Author)\Suite\Get" -Name "InstlTo" -ErrorAction SilentlyContinue
	} else {
		$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
		$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
	}

	$UI_Main_Save_To_Restore = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 480
		Padding        = "36,0,0,0"
		Text           = $lang.Restore
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""

			$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
			Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value $UI_Main_Save_To_Path.Text -String
			$UI_Main_Error.Text = "$($lang.Restore), $($lang.Done)"
		}
	}

	$UI_Main_InstlTo_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 480
	}

	$UI_Main_Adv_Name  = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 480
		Text           = $lang.AdvOption
	}

	$UI_Main_To_Name  = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 480
		Padding        = "20,0,0,0"
		Text           = $lang.Ok_Go_To
	}
	$UI_Main_To        = New-Object system.Windows.Forms.ComboBox -Property @{
		Height         = 30
		Width          = 420
		margin         = "40,0,0,0"
		Text           = ""
		DropDownStyle  = "DropDownList"
		add_Click      = {
			$UI_Main_Error.Text = ""
		}
	}

	$OKGoToNew = [Collections.ArrayList]@(
		[pscustomobject]@{ Path = "Main";    Lang = $lang.OK_Go_To_Main; }
		[pscustomobject]@{ Path = "Upgrade"; Lang = $lang.OK_Go_To_Upgrade_package; }
		[pscustomobject]@{ Path = "";        Lang = $lang.Ok_Go_To_No; }
	)

	$UI_Main_To.BindingContext = New-Object System.Windows.Forms.BindingContext
	$UI_Main_To.Datasource = $OKGoToNew
	$UI_Main_To.ValueMember = "Path"
	$UI_Main_To.DisplayMember = "Lang"

	$UI_Main_End_Wrap  = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 480
	}

	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 510
		Location       = "10,602"
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 255
		Location       = "8,635"
		Text           = $lang.OK
		add_Click      = {
			if (Download_UI_Save) {
				$UI_Main.Hide()
				Download_Process
				$UI_Main.Close()
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 255
		Location       = "268,635"
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Menu,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	$UI_Main_Menu.controls.AddRange((
		$UI_Main_Auto_Select,
		$UI_Main_List,
		$UI_Main_List_Wrap,
		$UI_Main_Save_To,
		$UI_Main_Save_To_Path,
		$UI_Main_Save_To_SelectFolder,
		$UI_Main_Save_To_OpenFolder,
		$UI_Main_Save_To_Paste,
		$UI_Main_Install_To_Name,
		$UI_Main_Install_To,
		$UI_Main_Save_To_Restore,
		$UI_Main_InstlTo_Wrap,
		$UI_Main_Adv_Name,
		$UI_Main_To_Name,
		$UI_Main_To,
		$UI_Main_End_Wrap
	))

	ForEach ($item in $Update_Server) {
		$CheckBox   = New-Object System.Windows.Forms.CheckBox -Property @{
			Height  = 35
			Width   = 435
			Text    = $item
			Tag     = $item
			Checked = $true
			add_Click = {
				$UI_Main_Error.Text = ""
			}
		}
		$UI_Main_List.controls.AddRange($CheckBox)
	}

	<#
		.Add right-click menu: select all, clear button
	#>
	$UI_Main_List_Select = New-Object System.Windows.Forms.ContextMenuStrip
	$UI_Main_List_Select.Items.Add($lang.AllSel).add_Click({
		$UI_Main_List.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$UI_Main_List_Select.Items.Add($lang.AllClear).add_Click({
		$UI_Main_List.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$UI_Main_List.ContextMenuStrip = $UI_Main_List_Select

	<#
		.Param
	#>
		<#
			.Custom update server
		#>
		if (-not [string]::IsNullOrEmpty($Cus)) {
			$UI_Main_Auto_Select.Checked = $False
			$UI_Main_List.Enabled = $True

			$WaitAdd = @()

			ForEach ($item in $Cus) {
				if ($Update_Server -notcontains $item) {
					$WaitAdd += $item
				}
			}

			if ($WaitAdd.Count -gt 0) {
				ForEach ($item in $WaitAdd) {
					$CheckBox   = New-Object System.Windows.Forms.CheckBox -Property @{
						Height  = 35
						Width   = 435
						Text    = $item
						Tag     = $item
						add_Click = {
							$UI_Main_Error.Text = ""
						}
					}
					$UI_Main_List.controls.AddRange($CheckBox)
				}
			}
			
			$UI_Main_List.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($Cus -Contains $_.Tag) {
						$_.ForeColor = "GREEN"
						$_.Checked = $True
					} else {
						$_.Checked = $False
					}
				}
			}
		}

		<#
			.User Interactive: Install to
		#>
		if (-not [string]::IsNullOrEmpty($To)) {
			switch ($To) {
				"AutoSelectDisk" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDisk)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
				}
				"Desktop" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDesktop)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
				}
				"Download" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
				}
				"Documents" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDocuments)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
				}
				default {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name -ErrorAction SilentlyContinue
				}
			}
		}

		<#
			.User Interactive: First visit to
		#>
		if (-not [string]::IsNullOrEmpty($GoTo)) {
			switch ($GoTo) {
				"Main" {
					$UI_Main_To.SelectedIndex = $UI_Main_To.FindString($lang.OK_Go_To_Main)
				}
				"Upgrade" {
					$UI_Main_To.SelectedIndex = $UI_Main_To.FindString($lang.OK_Go_To_Upgrade_package)
				}
				"No" {
					$UI_Main_To.SelectedIndex = $UI_Main_To.FindString($lang.Ok_Go_To_No)
				}
				default {
					$UI_Main_To.SelectedIndex = $UI_Main_To.FindString($lang.OK_Go_To_Main)
				}
			}
		}

	<#
		.User Interactive: User interactive: silent installation
	#>
	if ($Silent) {
		if (Download_UI_Save) {
			Download_Process
		} else {
			$UI_Main.ShowDialog() | Out-Null
		}
	} else {
		$UI_Main.ShowDialog() | Out-Null
	}
}

Function Download_UI_Save
{
	$Script:ServerList = @()

	if ($UI_Main_Auto_Select.Checked) {
		ForEach ($item in $Update_Server | Sort-Object { Get-Random } ) {
			$Script:ServerList += $item
		}
	} else {
		$UI_Main_List.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Checked) {
					$Script:ServerList += $_.Tag
				}
			}
		}

		if ($Script:ServerList.Count -gt 0) {
		} else {
			$UI_Main_Error.Text = $lang.UpdateServerNoSelect
			return $false
		}
	}

	if (Test-Path -Path $UI_Main_Save_To_Path.Text -PathType Container) {
		if (Test_Available_Disk -Path $UI_Main_Save_To_Path.Text) {
			if((Get-ChildItem $UI_Main_Save_To_Path.Text -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
				$UI_Main_Error.Text = $lang.IsOldFile
				return $false
			} else {
				return $true
			}
		} else {
			$UI_Main_Error.Text = $lang.FailedCreateFolder
			return $false
		}
	} else {
		if (Test_Available_Disk -Path $UI_Main_Save_To_Path.Text) {
			return $true
		} else {
			$UI_Main_Error.Text = $lang.FailedCreateFolder
			return $false
		}
	}
}

<#
	.Download process
#>
Function Download_Process
{
	Write-Host "   $($lang.UpdateCheckServerStatus -f $Script:ServerList.Count)
   $('-' * 80)"

	ForEach ($item in $Script:ServerList) {
		Write-Host "   * $($lang.UpdateServerAddress): " -NoNewline -ForegroundColor Yellow
		Write-Host $item -ForegroundColor Green

		if (Test_URI $item) {
			$PreServerVersion = $item
			$ServerTest = $true
			Write-Host "     $($lang.UpdateServeravailable)" -ForegroundColor Green
			break
		} else {
			Write-Host "     $($lang.UpdateServerUnavailable)`n" -ForegroundColor Red
		}
	}

	if ($ServerTest) {
		Write-Host "   $('-' * 80)"
		Write-Host "     $($lang.UpdatePriority)" -ForegroundColor Green
	} else {
		Write-Host "     $($lang.UpdateServerTestFailed)" -ForegroundColor Red
		Write-Host "   $('-' * 80)"
		return
	}

	Write-host "`n   $($lang.UpdateQueryingUpdate)"

	$RandomGuid = [guid]::NewGuid()
	$Temp_Main_Path = Join-Path -Path $env:TEMP -ChildPath $RandomGuid -ErrorAction SilentlyContinue
	New-Item -Path $Temp_Main_Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

	$NewFileName = [IO.Path]::GetFileName($item)
	$NewFilePath = Join-Path -Path $Temp_Main_Path -ChildPath $NewFileName -ErrorAction SilentlyContinue

	$error.Clear()
	$time = Measure-Command { Invoke-WebRequest -Uri $PreServerVersion -OutFile $NewFilePath -TimeoutSec 15 -ErrorAction stop }

	if ($error.Count -eq 0) {
		Write-Host "`n   $($lang.UpdateQueryingTime -f $time.TotalMilliseconds)"
	} else {
		Write-host "`n   $($lang.UpdateConnectFailed)"
		return
	}

	Write-host "`n   $($lang.InstlTo): " -NoNewline -ForegroundColor Yellow
	Write-host $UI_Main_Save_To_Path.Text -ForegroundColor Green
	Write-host "   $('-' * 80)"
	if (Test-Path -Path $NewFilePath -PathType leaf) {
		Add-Type -AssemblyName System.IO.Compression.FileSystem

		if (TestArchive -Path $NewFilePath) {
			Archive -filename $NewFilePath -to $UI_Main_Save_To_Path.Text
			remove-item -path $Temp_Main_Path -force -Recurse -ErrorAction silentlycontinue | Out-Null

			Write-Host "`n   $($lang.Ok_Go_To)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if ([string]::IsNullOrEmpty($UI_Main_To.SelectedItem.Path)) {
				write-host "   $($lang.Ok_Go_To_No)" -ForegroundColor Red
			} else {
				switch ($UI_Main_To.SelectedItem.Path) {
					"Main" {
						Write-host "   $($lang.Ok_Go_To_Main)" -ForegroundColor Yellow
						$Solutions_PS = Join-Path -Path $UI_Main_Save_To_Path.Text -ChildPath "Engine.ps1" -ErrorAction SilentlyContinue
						if (Test-Path -Path $Solutions_PS -PathType leaf) {
							write-host "   $($lang.Done)" -ForegroundColor Green
							Start-Process "powershell" -ArgumentList "-ExecutionPolicy ByPass -file ""$($Solutions_PS)""" -NoNewWindow
						} else {
							write-host "   $($lang.Inoperable)" -ForegroundColor Red
						}
					}
					"Upgrade" {
						Write-host "   $($lang.OK_Go_To_Upgrade_package)" -ForegroundColor Yellow
						$Solutions_PS = Join-Path -Path $UI_Main_Save_To_Path.Text -ChildPath "_Create.Upgrade.Package.ps1" -ErrorAction SilentlyContinue
						if (Test-Path -Path $Solutions_PS -PathType leaf) {
							write-host "   $($lang.Done)" -ForegroundColor Green
							Start-Process "powershell" -ArgumentList "-ExecutionPolicy ByPass -file ""$($Solutions_PS)""" -NoNewWindow
						} else {
							write-host "   $($lang.Inoperable)" -ForegroundColor Red
						}
					}
					default {
						write-host "   $($lang.Ok_Go_To_No)" -ForegroundColor Red
					}
				}
			}
		} else {
			write-host "   $($lang.FileFormatError)"
			remove-item -path $Temp_Main_Path -force -Recurse -ErrorAction silentlycontinue | Out-Null
		}
	} else {
		Write-host "   $($lang.UpdateConnectFailed)"
		remove-item -path $Temp_Main_Path -force -Recurse -ErrorAction silentlycontinue | Out-Null
	}
}

<#
	.Set language pack, usage:
	 Language          | Language selected by the user
	 Language "zh-CN"  | Mandatory use of specified language
#>
if ($Language) {
	$IsMatch = $True
	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq $Language) {
			$Global:lang = $item.Language
			$Global:IsLang = $item.Tag
			$IsMatch = $False
			break
		}
	}

	if ($IsMatch) {
		ForEach ($item in $AvailableLanguages) {
			if ($item.Tag -eq "en-US") {
				$Global:lang = $item.Language
				$Global:IsLang = $item.Tag
				$IsMatch = $False
				break
			}
		}
	}
} else {
	Language
}

<#
	.Prerequisites
#>
Prerequisite

<#
	.Installation interface
#>
Installation_interface_UI