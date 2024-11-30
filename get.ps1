<#
	.Summary
	 Yi's Solutions

	.Open "Terminal" or "PowerShell ISE" as an administrator,
	 set PowerShell execution policy: Bypass, PS command line: 

	 Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

	.Example
	 PS C:\> .\_get.ps1                   | User interactive
	 PS C:\> .\_get.ps1 -Reset            | Reset script usage history

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

	.About
	 Author:  Yi
	 Website: http://fengyi.tel
#>

[CmdletBinding()]
param
(
	[String]
	$Language,

	[Switch]
	$Reset,

	[String[]]
	$Cus,

	[String]
	$To,

	[String]
	$GoTo,

	[switch]
	$Silent
)

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
			FontsUI                  = "Segoe UI"
			Get                      = "Get Yi's Suite online"
			UpdateServerSelect       = "Automatic server selection or custom selection"
			UpdateServerNoSelect     = "Please select an available server"
			UpdatePriority           = "has been set as priority"
			UpdateServerTestFailed   = "Failed server status test"
			UpdateQueryingUpdate     = "Querying and updating..."
			UpdateQueryingTime       = "Checking if the latest version is available,`n   the connection took {0} milliseconds."
			UpdateConnectFailed      = "Unable to connect to the remote server, access to online has been aborted."
			UpdateCheckServerStatus  = "Check server status ( total {0} optional )"
			UpdateServerAddress      = "Server address"
			UpdateServeravailable    = "Status: Available"
			UpdateServerUnavailable  = "Status: Unavailable"
			InstlTo                  = "Install to, new name"
			SelectFolder             = "Select directory"
			OpenFolder               = "Open Directory"
			Paste                    = "Copy path"
			FailedCreateFolder       = "Failed to create directory"
			Failed                   = "Failed"
			IsOldFile                = "Please delete the old file and try again"
			Restore                  = "Restore to default save path"
			RestoreTo                = "When restoring the saved path, automatically select"
			RestoreToDisk            = "Automatically select available disk"
			RestoreToDesktop         = "Desktop"
			RestoreToDownload        = "Download"
			RestoreToDocuments       = "Documents"
			FileName                 = "File name"
			Done                     = "Done"
			Inoperable               = "Inoperable"
			FileFormatError          = "File format error."
			AdvOption                = "Optional function"
			Ok_Go_To                 = "First visit to"
			Ok_Go_To_Main            = "Main Program"
			Ok_Go_To_No              = "Not going"
			OK_Go_To_Upgrade_package = "Creating an upgrade package"
			Unpacking                = "Unpacking"
			Running                  = "Running"
			SaveTo                   = "Save to"
			OK                       = "OK"
			Cancel                   = "Cancel"
			UserCancel               = "The user has cancelled the operation."
			AllSel                   = "Select all"
			AllClear                 = "Clear all"
			Prerequisites            = "Prerequisites"
			Check_PSVersion          = "Checking PS version 5.1 and above"
			Check_OSVersion          = "Checking Windows version > 10.0.16299.0"
			Check_Higher_elevated    = "Checking Must be elevated to higher authority"
			Check_execution_strategy = "Check execution strategy"
			Check_Pass               = "Pass"
			Check_Did_not_pass       = "Did not pass"
			Check_Pass_Done          = "Congratulations, it has passed."
			How_solve                = "How to solve it"
			UpdatePSVersion          = "Please install the latest PowerShell version"
			UpdateOSVersion          = "1. Go to the official Microsoft website to download the latest`n       version of the operating system`n`n    2. Install the latest version of the operating system and try again"
			HigherTermail            = "1. Open ""Terminal"" or ""PowerShell ISE"" as an administrator, `n       set PowerShell execution policy: Bypass, PS command line: `n`n       Set-ExecutionPolicy -ExecutionPolicy Bypass -Force`n`n    2. Once resolved, rerun the command."
			HigherTermailAdmin       = "1. Open Terminal or PowerShell ISE as an administrator.`n     2. Once resolved, rerun the command."
		}
	}
	@{
		Tag      = "ja-JP"
		Name     = "Japanese (Japan)"
		Language = @{
			FontsUI                  = "Yu Gothic UI"
			Get                      = "Yi's Suite をオンラインで入手する"
			UpdateServerSelect       = "自動サーバー選択またはカスタム選択"
			UpdateServerNoSelect     = "利用可能なサーバーを選択してください"
			UpdatePriority           = "すでに優先として設定されています"
			UpdateServerTestFailed   = "サーバーステータステストの失敗"
			UpdateQueryingUpdate     = "更新を問い合わせています..."
			UpdateQueryingTime       = "最新バージョンが利用可能かどうかの確認に、接続に {0} ミリ秒かかりました。"
			UpdateConnectFailed      = "リモートサーバーに接続できず、アップデートのチェックが中止されました。"
			UpdateCheckServerStatus  = "サーバーのステータスを確認します ({0} 個のオプションが利用可能)"
			UpdateServerAddress      = "サーバーアドレス"
			UpdateServeravailable    = "ステータス: 利用可能"
			UpdateServerUnavailable  = "ステータス: 利用不可"
			InstlTo                  = "インストール先、新しい名前"
			SelectFolder             = "ディレクトリの選択"
			OpenFolder               = "ディレクトリを開く"
			Paste                    = "パスをコピーする"
			FailedCreateFolder       = "ディレクトリの作成に失敗しました"
			Failed                   = "失敗"
			IsOldFile                = "古いファイルを削除して再試行してください"
			Restore                  = "デフォルトの保存パスを復元する"
			RestoreTo                = "保存パスを復元するときに自動的に選択されます"
			RestoreToDisk            = "利用可能なディスクを自動的に選択する"
			RestoreToDesktop         = "デスクトップ"
			RestoreToDownload        = "ダウンロード"
			RestoreToDocuments       = "書類"
			FileName                 = "ファイル名"
			Done                     = "仕上げる"
			Inoperable               = "動作不能"
			FileFormatError          = "ファイル形式が正しくありません"
			AdvOption                = "オプション機能"
			Ok_Go_To                 = "利用可能"
			Ok_Go_To_Main            = "メインプログラム"
			Ok_Go_To_No              = "行かない"
			OK_Go_To_Upgrade_package = "アップグレードパッケージの作成"
			Unpacking                = "解凍中"
			Running                  = "ランニング"
			SaveTo                   = "に保存する"
			OK                       = "もちろん"
			Cancel                   = "キャンセル"
			UserCancel               = "ユーザーが操作をキャンセルしました。"
			AllSel                   = "すべて選択"
			AllClear                 = "すべてクリアする"
			Prerequisites            = "前提条件"
			Check_PSVersion          = "PS バージョン 5.1 以降を確認してください"
			Check_OSVersion          = "Windows バージョン > 10.0.16299.0 を確認してください"
			Check_Higher_elevated    = "チェックはより高い特権に昇格する必要があります"
			Check_execution_strategy = "実行戦略を確認する"
			Check_Pass               = "合格"
			Check_Did_not_pass       = "失敗した"
			Check_Pass_Done          = "おめでとうございます、合格しました。"
			How_solve                = "解決方法"
			UpdatePSVersion          = "最新の PowerShell バージョンをインストールしてください"
			UpdateOSVersion          = "1. Microsoft の公式 Web サイトにアクセスして、`n       オペレーティング システムの最新バージョンをダウンロードします。`n    2. 最新バージョンのオペレーティング システムをインストールして再試行してください"
			HigherTermail            = "1. 管理者としてターミナルまたは PowerShell ISE を開きます。`n       设置 PowerShell 执行策略：绕过，PS命令行：`n`n       Set-ExecutionPolicy -ExecutionPolicy Bypass -Force`n`n    2. 解決したら、コマンドを再実行します。"
			HigherTermailAdmin       = "1. 管理者としてターミナルまたは PowerShell ISE を開きます。`n     2. 解決したら、コマンドを再実行します。"
		}
	}
	@{
		Tag      = "ko-KR"
		Name     = "Korean (Korea)"
		Language = @{
			FontsUI                  = "Malgun Gothic"
			Get                      = "Yi's Suite 를 온라인으로 구매하세요"
			UpdateServerSelect       = "자동 서버 선택 또는 사용자 정의 선택"
			UpdateServerNoSelect     = "사용 가능한 서버를 선택해주세요"
			UpdatePriority           = "이미 우선순위로 설정됨"
			UpdateServerTestFailed   = "서버 상태 테스트 실패"
			UpdateQueryingUpdate     = "업데이트를 쿼리하는 중..."
			UpdateQueryingTime       = "최신 버전을 사용할 수 있는지 확인하는 데 {0} 밀리초가 걸렸습니다."
			UpdateConnectFailed      = "원격 서버에 연결할 수 없습니다. 업데이트 확인이 중단되었습니다."
			UpdateCheckServerStatus  = "서버 상태 확인 ({0} 옵션 사용 가능)"
			UpdateServerAddress      = "서버 주소"
			UpdateServeravailable    = "상태: 사용 가능"
			UpdateServerUnavailable  = "상태: 사용할 수 없음"
			InstlTo                  = "설치 위치, 새 이름"
			SelectFolder             = "디렉토리 선택"
			OpenFolder               = "디렉토리 열기"
			Paste                    = "경로 복사"
			FailedCreateFolder       = "디렉터리를 생성하지 못했습니다."
			Failed                   = "실패했습니다"
			IsOldFile                = "오래된 파일을 삭제하고 다시 시도해주세요"
			Restore                  = "기본 저장 경로 복원"
			RestoreTo                = "저장 경로 복원 시 자동 선택"
			RestoreToDisk            = "사용 가능한 디스크 자동 선택"
			RestoreToDesktop         = "데스크탑"
			RestoreToDownload        = "다운로드"
			RestoreToDocuments       = "문서"
			FileName                 = "파일 이름"
			Done                     = "마치다"
			Inoperable               = "작동불가"
			FileFormatError          = "파일 형식이 잘못되었습니다."
			AdvOption                = "선택적 기능"
			Ok_Go_To                 = "사용 가능"
			Ok_Go_To_Main            = "메인 프로그램"
			Ok_Go_To_No              = "안 가요"
			OK_Go_To_Upgrade_package = "업그레이드 패키지 생성"
			Unpacking                = "압축 해제 중"
			Running                  = "달리기"
			SaveTo                   = "다음에 저장"
			OK                       = "확신하는"
			Cancel                   = "취소"
			UserCancel               = "사용자가 작업을 취소했습니다."
			AllSel                   = "모두 선택"
			AllClear                 = "모두 지우기"
			Prerequisites            = "전제 조건"
			Check_PSVersion          = "PS 버전 5.1 이상을 확인하세요"
			Check_OSVersion          = "Windows 버전 > 10.0.16299.0 확인"
			Check_Higher_elevated    = "수표를 더 높은 권한으로 올려야 합니다"
			Check_execution_strategy = "실행 전략 확인"
			Check_Pass               = "통과하다"
			Check_Did_not_pass       = "실패한"
			Check_Pass_Done          = "축하해요, 합격했어요."
			How_solve                = "해결 방법"
			UpdatePSVersion          = "최신 PowerShell 버전을 설치하세요."
			UpdateOSVersion          = "1. 최신 버전의 운영 체제를 다운로드하려면 Microsoft 공식 웹사이트로 이동하세요.`n    2. 최신 버전의 운영 체제를 설치하고 다시 시도해 보세요."
			HigherTermail            = "1. 터미널 또는 PowerShell ISE를 관리자로 열고, `n       PowerShell 실행 정책 설정: 우회, PS 명령줄:`n`n       Set-ExecutionPolicy -ExecutionPolicy Bypass -Force`n`n    2. 해결되면 명령을 다시 실행하십시오."
			HigherTermailAdmin       = "1. 터미널 또는 PowerShell ISE를 관리자로 엽니다.`n     2. 해결되면 명령을 다시 실행하십시오."
		}
	}
	@{
		Tag      = "zh-CN"
		Name     = "Chinese (Simplified, China)"
		Language = @{
			FontsUI                  = "Microsoft YaHei UI"
			Get                      = "在线获取 Yi's Suite"
			UpdateServerSelect       = "自动选择服务器或自定义选择"
			UpdateServerNoSelect     = "请选择可用的服务器"
			UpdatePriority           = "已设置为优先级"
			UpdateServerTestFailed   = "未通过服务器状态测试"
			UpdateQueryingUpdate     = "正在查询更新中..."
			UpdateQueryingTime       = "正检查是否有最新版本可用，连接耗时 {0} 毫秒。"
			UpdateConnectFailed      = "无法连接到远程服务器，检查更新已中止。"
			UpdateCheckServerStatus  = "检查服务器状态 ( 共 {0} 个可选 )"
			UpdateServerAddress      = "服务器地址"
			UpdateServeravailable    = "状态：可用"
			UpdateServerUnavailable  = "状态：不可用"
			InstlTo                  = "安装到，新名称"
			SelectFolder             = "选择目录"
			OpenFolder               = "打开目录"
			Paste                    = "复制路径"
			FailedCreateFolder       = "创建目录失败"
			Failed                   = "失败"
			IsOldFile                = "请删除旧文件后重试"
			Restore                  = "恢复默认保存路径"
			RestoreTo                = "恢复保存路径时自动选择"
			RestoreToDisk            = "自动选择可用磁盘"
			RestoreToDesktop         = "桌面"
			RestoreToDownload        = "下载"
			RestoreToDocuments       = "文档"
			FileName                 = "文件名"
			Done                     = "完成"
			Inoperable               = "不可操作"
			FileFormatError          = "文件格式不正确"
			AdvOption                = "可选功能"
			Ok_Go_To                 = "可前往"
			Ok_Go_To_Main            = "主程序"
			Ok_Go_To_No              = "不前往"
			OK_Go_To_Upgrade_package = "创建升级包"
			Unpacking                = "正在解压"
			Running                  = "运行中"
			SaveTo                   = "保存到"
			OK                       = "确定"
			Cancel                   = "取消"
			UserCancel               = "用户已取消操作。"
			AllSel                   = "选择所有"
			AllClear                 = "清除所有"
			Prerequisites            = "先决条件"
			Check_PSVersion          = "检查 PS 版本 5.1 及以上"
			Check_OSVersion          = "检查 Windows 版本 > 10.0.16299.0"
			Check_Higher_elevated    = "检查必须提升至更高权限"
			Check_execution_strategy = "检查执行策略"
			Check_Pass               = "通过"
			Check_Did_not_pass       = "没有通过"
			Check_Pass_Done          = "恭喜，通过了。"
			How_solve                = "如何解决"
			UpdatePSVersion          = "请安装最新的 PowerShell 版本"
			UpdateOSVersion          = "1. 前往微软官方网站下载最新版本的操作系统`n    2. 安装最新版本的操作系统并重试"
			HigherTermail            = "1. 以管理员身份打开 ""终端"" 或 ""PowerShell ISE""，`n       设置 PowerShell 执行策略：绕过，PS命令行：`n`n       Set-ExecutionPolicy -ExecutionPolicy Bypass -Force`n`n    2. 解决后，重新运行命令。"
			HigherTermailAdmin       = "1. 以管理员身份打开 ""终端"" 或 ""PowerShell ISE""。`n     2. 解决后，重新运行命令。"
		}
	}
	@{
		Tag      = "zh-TW"
		Name     = "Chinese (Traditional, Taiwan)"
		Language = @{
			FontsUI                  = "Microsoft JhengHei UI"
			Get                      = "在線獲取 Yi's Suite"
			UpdateServerSelect       = "自動選擇伺服器或自訂選擇"
			UpdateServerNoSelect     = "請選擇可用的伺服器"
			UpdatePriority           = "已設定為優先權"
			UpdateServerTestFailed   = "未通過伺服器狀態測試"
			UpdateQueryingUpdate     = "正在查詢更新中..."
			UpdateQueryingTime       = "正檢查是否有最新版本可用，連線耗時 {0} 毫秒。"
			UpdateConnectFailed      = "無法連線到遠端伺服器，檢查更新已中止。"
			UpdateCheckServerStatus  = "檢查伺服器狀態 ( 共 {0} 個可選 )"
			UpdateServerAddress      = "伺服器位址"
			UpdateServeravailable    = "狀態：可用"
			UpdateServerUnavailable  = "狀態：不可用"
			InstlTo                  = "安裝到，新名稱"
			SelectFolder             = "選擇目錄"
			OpenFolder               = "開啟目錄"
			Paste                    = "複製路徑"
			FailedCreateFolder       = "建立目錄失敗"
			Failed                   = "失敗"
			IsOldFile                = "請刪除舊檔案後重試"
			Restore                  = "恢復預設儲存路徑"
			RestoreTo                = "恢復儲存路徑時自動選擇"
			RestoreToDisk            = "自動選擇可用磁碟"
			RestoreToDesktop         = "桌面"
			RestoreToDownload        = "下載"
			RestoreToDocuments       = "文件"
			FileName                 = "檔案名稱"
			Done                     = "完成"
			Inoperable               = "不可操作"
			FileFormatError          = "文件格式不正確"
			AdvOption                = "選用功能"
			Ok_Go_To                 = "可前往"
			Ok_Go_To_Main            = "主程式"
			Ok_Go_To_No              = "不前往"
			OK_Go_To_Upgrade_package = "創建升級包"
			Unpacking                = "正在解壓縮"
			Running                  = "運作中"
			SaveTo                   = "儲存到"
			OK                       = "確定"
			Cancel                   = "取消"
			UserCancel               = "使用者已取消操作。"
			AllSel                   = "選擇所有"
			AllClear                 = "清除所有"
			Prerequisites            = "先決條件"
			Check_PSVersion          = "檢查 PS 版本 5.1 以上"
			Check_OSVersion          = "檢查 Windows 版本 > 10.0.16299.0"
			Check_Higher_elevated    = "檢查必須提升至更高權限"
			Check_execution_strategy = "檢查執行策略"
			Check_Pass               = "透過"
			Check_Did_not_pass       = "沒有通過"
			Check_Pass_Done          = "恭喜，通過了。"
			How_solve                = "如何解決"
			UpdatePSVersion          = "請安裝最新的 PowerShell 版本"
			UpdateOSVersion          = "1. 前往微軟官方網站下載最新版本的作業系統`n    2. 安裝最新版本的作業系統並重試"
			HigherTermail            = "1. 以管理員身分開啟 ""終端"" 或 ""PowerShell ISE""，`n       設定 PowerShell 執行策略：繞過，PS命令列：`n`n       Set-ExecutionPolicy -ExecutionPolicy Bypass -Force`n`n    2. 解決後，重新運行命令。"
			HigherTermailAdmin       = "1. 以管理員身分開啟 ""終端"" 或 ""PowerShell ISE""。`n     2. 解決後，重新運行命令。"
		}
	}
)

Function Language
{
	param
	(
		$NewLang = (Get-Culture).Name
	)

	$Global:lang = @()
	$Global:IsLang = ""

	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq $NewLang) {
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
	exit
}

<#
	.Prerequisite
#>
Function Prerequisite
{
	Clear-Host
	$Host.UI.RawUI.WindowTitle = "$($lang.Get) | $($lang.Prerequisites)"
	Write-Host "`n   $($lang.Prerequisites)" -ForegroundColor Yellow
	Write-host "   $('-' * ($lang.Prerequisites).Length)"

	Write-Host "   $($lang.Check_PSVersion): " -NoNewline
	if ($PSVersionTable.PSVersion.major -ge "5") {
		Write-Host $lang.Check_Pass -ForegroundColor Green
	} else {
		Write-Host $lang.Failed -ForegroundColor Red

		Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
		Write-host "   $('-' * ($lang.How_solve).Length)"
		Write-host "     1. $($lang.UpdatePSVersion)`n"
		pause
		exit
	}

	Write-Host "   $($lang.Check_OSVersion): " -NoNewline
	$OSVer = [System.Environment]::OSVersion.Version;
	if (($OSVer.Major -eq 10 -and $OSVer.Minor -eq 0 -and $OSVer.Build -ge 16299)) {
		Write-Host $lang.Check_Pass -ForegroundColor Green
	} else {
		Write-Host $lang.Failed -ForegroundColor Red

		Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
		Write-host "   $('-' * ($lang.How_solve).Length)"
		Write-host "    $($lang.UpdateOSVersion)`n"
		pause
		exit
	}

	Write-Host "   $($lang.Check_Higher_elevated): " -NoNewline
	if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
		Write-Host $lang.Check_Pass -ForegroundColor Green

		Write-Host "   $($lang.Check_execution_strategy): " -NoNewline
		switch (Get-ExecutionPolicy) {
			"Bypass" {
				Write-Host $lang.Check_Pass -ForegroundColor Green
			}
			"RemoteSigned" {
				Write-Host $lang.Check_Pass -ForegroundColor Green
			}
			"Unrestricted" {
				Write-Host $lang.Check_Pass -ForegroundColor Green
			}
			default {
				Write-Host $lang.Check_Did_not_pass -ForegroundColor Red
	
				Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
				Write-host "   $('-' * ($lang.How_solve).Length)"
				Write-host "    $($lang.HigherTermail)`n"
				pause
				exit
			}
		}
	} else {
		Write-Host $lang.Failed -ForegroundColor Red

		Write-host "`n   $($lang.How_solve): " -ForegroundColor Yellow
		Write-host "   $('-' * ($lang.How_solve).Length)"
		Write-host "     $($lang.HigherTermailAdmin)`n"
		pause
		exit
	}

	Write-Host "`n   $($lang.Check_Pass_Done)" -ForegroundColor Green
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

	$Path = "HKCU:\SOFTWARE\Yi\$($regkey)"

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

		Write-Host $lang.Done -ForegroundColor Green
	} else {
		Add-Type -AssemblyName System.IO.Compression.FileSystem
		Expand-Archive -LiteralPath $filename -DestinationPath $to -force
		Write-Host $lang.Done -ForegroundColor Green
	}

	Write-Host
}

Function TestArchive
{
	param
	(
		$Path
	)

	Add-Type -Assembly System.IO.Compression.FileSystem

	Try {
		$zipFile = [System.IO.Compression.ZipFile]::OpenRead($Path)
		$zipFile.Dispose()
		Return $true
	} Catch {
		$zipFile.Dispose()
		Return $false
	} Finally {
		If ($zipFile) {
			Try {
				$zipFile.Dispose()
			} Catch {
				
			}
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
		$test_filename = Join-Path -Path $Path -ChildPath $test_tmp_filename

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
				$test.BaseResponse | Select-Object ResponseURI, ContentLength, ContentType, LastModified, @{
					Name = "Status";
					Expression = {
						$Test.StatusCode
					}
				}
			} else {
				if ($test.statuscode -ne 200) {
					$False
				} else {
					$True
				}
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
			} else {
				$False
			}
		}
	}
}

Function Installation_interface_UI
{
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	Write-Host "`n   $($lang.Get)"
	Write-Host "   $('-' * ($lang.Get).Length)"

	Function Install_Init_Disk_To
	{
		switch ($UI_Main_Install_To.SelectedItem.Path) {
			"AutoSelectDisk" {
				Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value "AutoSelectDisk" -String

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
				Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value "Desktop" -String
				return [Environment]::GetFolderPath("Desktop")
			}
			"Download" {
				Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value "Download" -String
				return (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
			}
			"Documents" {
				Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value "Documents" -String
				return [Environment]::GetFolderPath("MyDocuments")
			}
			default {
				Save_Dynamic -regkey "Suite\Get" -name "InstlTo" -value "Download" -String
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
		Font           = New-Object System.Drawing.Font($lang.FontsUI, 9, [System.Drawing.FontStyle]::Regular)
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
		Height         = 25
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
		Margin         = "25,5,0,20"
		Text           = ""
		Enabled        = $False
	}

	$UI_Main_Save_To_SelectFolder = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 40
		Width          = 480
		Padding        = "23,0,5,0"
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
					$UI_Main_Save_To_Path.Text = Join-Path -Path $FolderBrowser.SelectedPath -ChildPath $Default_directory_name
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
		Padding        = "23,0,0,0"
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
		Padding        = "23,0,0,0"
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

	$UI_Main_Save_To_Wrap  = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 480
	}

	$UI_Main_Install_To_Name = New-Object System.Windows.Forms.Label -Property @{
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

	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\Yi\Suite\Get" -Name "InstlTo" -ErrorAction SilentlyContinue) {
		$GetNewInstallTo = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Yi\Suite\Get" -Name "InstlTo"
		switch ($GetNewInstallTo) {
			"AutoSelectDisk" {
				$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDisk)
			}
			"Desktop" {
				$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDesktop)
			}
			"Download" {
				$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
			}
			"Documents" {
				$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDocuments)
			}
			default {
				$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
			}
		}
	} else {
		$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
	}
	$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name

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

			$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name
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
		$UI_Main_Save_To_Wrap,
		$UI_Main_Adv_Name,
		$UI_Main_Install_To_Name,
		$UI_Main_Install_To,
		$UI_Main_Save_To_Restore,
		$UI_Main_InstlTo_Wrap,
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
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name
				}
				"Desktop" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDesktop)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name
				}
				"Download" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name
				}
				"Documents" {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDocuments)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name
				}
				default {
					$UI_Main_Install_To.SelectedIndex = $UI_Main_Install_To.FindString($lang.RestoreToDownload)
					$UI_Main_Save_To_Path.Text = Join-Path -Path $(Install_Init_Disk_To) -ChildPath $Default_directory_name
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
	$Temp_Main_Path = Join-Path -Path $env:TEMP -ChildPath $RandomGuid
	New-Item -Path $Temp_Main_Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

	$NewFileName = [IO.Path]::GetFileName($item)
	$NewFilePath = Join-Path -Path $Temp_Main_Path -ChildPath $NewFileName

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
		if (TestArchive -Path $NewFilePath) {
			Save_Dynamic -regkey "Suite\Get" -name "InstlToHistory" -value $UI_Main_Save_To_Path.Text -String

			Archive -filename $NewFilePath -to $UI_Main_Save_To_Path.Text
			remove-item -path $Temp_Main_Path -force -Recurse -ErrorAction silentlycontinue | Out-Null

			if ([string]::IsNullOrEmpty($UI_Main_To.SelectedItem.Path)) {
				Write-Host "`n   $($lang.Ok_Go_To): " -NoNewline -ForegroundColor Yellow
				write-host $lang.Ok_Go_To_No -ForegroundColor Red
			} else {
				Write-Host "`n   $($lang.Ok_Go_To): " -NoNewline -ForegroundColor Yellow

				switch ($UI_Main_To.SelectedItem.Path) {
					"Main" {
						Write-host $lang.Ok_Go_To_Main -ForegroundColor Green
						Write-Host "   $('-' * 80)"

						$Solutions_PS = Join-Path -Path $UI_Main_Save_To_Path.Text -ChildPath "Engine.ps1"
						if (Test-Path -Path $Solutions_PS -PathType leaf) {
							Write-Host "   $($lang.Filename): " -NoNewline -ForegroundColor Yellow
							Write-Host $Solutions_PS -ForegroundColor Green

							Write-Host "   $($lang.Running)".PadRight(28) -NoNewline
							Start-Process "powershell" -ArgumentList "-ExecutionPolicy ByPass -file ""$($Solutions_PS)"""
							Write-host $lang.Done -ForegroundColor Green

							Write-Host "`n   $('-' * 80)"
							Write-Host "   $($lang.Ok_Go_To): $($lang.Ok_Go_To_Main), $($lang.Done)" -ForegroundColor Green
						} else {
							write-host "   $($lang.Inoperable)" -ForegroundColor Red
						}
					}
					"Upgrade" {
						Write-host $lang.OK_Go_To_Upgrade_package -ForegroundColor Green
						Write-Host "   $('-' * 80)"

						$Solutions_PS = Join-Path -Path $UI_Main_Save_To_Path.Text -ChildPath "_Create.Upgrade.Package.ps1"
						if (Test-Path -Path $Solutions_PS -PathType leaf) {
							Write-Host "   $($lang.Filename): " -NoNewline -ForegroundColor Yellow
							Write-Host $Solutions_PS -ForegroundColor Green

							Write-Host "   $($lang.Running)".PadRight(28) -NoNewline
							Start-Process "powershell" -ArgumentList "-ExecutionPolicy ByPass -file ""$($Solutions_PS)"""
							Write-host $lang.Done -ForegroundColor Green

							Write-Host "`n   $('-' * 80)"
							Write-Host "   $($lang.Ok_Go_To): $($lang.OK_Go_To_Upgrade_package), $($lang.Done)" -ForegroundColor Green
						} else {
							write-host "   $($lang.Inoperable)" -ForegroundColor Red
						}
					}
					default {
						Write-host $lang.Ok_Go_To_No -ForegroundColor Red
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
	.Reset script usage history
#>
if ($Reset) {
	$Path = "HKCU:\SOFTWARE\Yi\Suite\Get"
	Remove-Item -Path $Path -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
}

<#
	.Set language pack, usage:
	 Language                  | Language selected by the user
	 Language -NewLang "zh-CN" | Mandatory use of specified language
#>
if ($Language) {
	Language -NewLang $Language
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