QUICK DOWNLOAD GUIDE
-

Open "Terminal" or "PowerShell ISE" as an administrator, paste the following command line into the "Terminal" dialog box, and press Enter to start running;

<br>

Open "Terminal" or "PowerShell ISE" as an administrator, set PowerShell execution policy: Bypass, PS command line:
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
```

<br>

a) Prioritize downloading from Github node
```
curl https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -o get.ps1; .\get.ps1;
wget https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -O get.ps1; .\get.ps1;
iwr https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -out get.ps1; .\get.ps1;
Invoke-WebRequest https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -OutFile get.ps1; .\get.ps1;
```

<br>

b) Prioritize downloading from Yi node
```
curl https://fengyi.tel/ys -o get.ps1; .\get.ps1;
wget https://fengyi.tel/ys -O get.ps1; .\get.ps1;
iwr https://fengyi.tel/ys -out get.ps1; .\get.ps1;
Invoke-WebRequest https://fengyi.tel/ys -OutFile get.ps1; .\get.ps1;
```

<p>After running the installation script, users can customize the installation interface: specify the download link, specify the installation location, go to: main program, create upgrade package, etc.</p>
<p>You can choose any one: interactive experience installation and custom installation to meet different installation requirements. Multiple different commands are provided during downloading: Curl, Wget, iwr, Invoke-WebRequest. When copying the download link, just copy any one.</p>

<br>

Learn
 * [How to customize the installation script interactive experience](https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Get/Get.pdf)

<br>

Available languages
-
 * [简体中文 - 中国](https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Readme/README.zh-CN.md)

<br>

Yi's Suite

<h4><pre>Require</pre></h4>
<p>PowerShell Version</p>

* PowerShell 5.1
    * Requires Windows 11, Windows 10, Windows Server 2022, Windows Server vNext or the 5.1 version that comes with the system by default. You can optionally upgrade to the latest version of PowerShell 7.

<br>

* PowerShell 7
    * To get the latest version, go to https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows, select the version you want to download, download and install.

<br>

<h4><pre>Command Line</pre></h4>

* You can choose "Terminal" or "PowerShell ISE". If "Terminal" is not installed, please go to https://github.com/microsoft/terminal/releases to download;

* Open "Terminal" or "PowerShell ISE" as an administrator, set PowerShell execution policy: Bypass, PS command line:

```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
```

   * After the download is completed, unzip it to any disk, for example, unzip it to: D:\Yi.Suite

   * After finding D:\Yi.Suite\Engine\Engine.ps1, right-click the file and select Run as PowerShell, or copy the path and paste it into "Terminal" or "PowerShell ISE" to run. The path with a colon is in the command Add the & character to the line, example: & "D:\Yi.Suite\Engine\Engine.ps1"

<br>
<h4><pre>The main function: </pre></h4>
<ul>1. Support online upgrade;</ul>
<ul>2. Support hot refresh after modifying the script;</ul>
<ul>3. Customized creation of upgrade packages</ul>
<ul><dl><dd>

[Learn: How to create a custom upgrade package](https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Custom.upgrade.package)
</dd></dd></ul>

<br>
<ul>
   <p>4. Custom deployment mechanism</p>
   <dl>
      <dd>4.1. Implement deployment rules according to description files;</dd>
      <dd>4.2. Get the installed language pack and add it automatically;</dd>
      <dd>4.3. During the adding process, the S and SN versions are automatically determined and added according to the rules;</dd>
      <dd>4.4. Automatic addition mechanism:
         <dl>
            <dd>
               <p>4.4.1. When encountering the monolingual version, </p>
               <dl>
                  <dd>When only single language is used, the current language is automatically added as the global preferred language;</dd>
                  <dd>When the monolingual version contains multi-language packages, 
                     <dl>
                        <dd>After adding the preferred language, if en-US is among the languages waiting to be added, it will be added as the second language first;</dd>
                        <dd>If there is no en-US, the installed language is randomly selected as the second language.</dd>
                        <dd>For example, single language version tags: CoreSingleLanguage, CoreCountrySpecific</dd>
                     </dl>
                  </dd>
               </dl>
            </dd>

<br>
            <dd>
               <p>4.4.2. When encountering the multilingual version, </p>
               <dl>
                  <dd>After adding your preferred language, all installed languages are automatically added.</dd>
               </dl>
            </dd>
         </dl>
      </dd>
   </dl>
</ul>

<br>
<ul>5. Custom deployment tags</ul>

<ul><dl><dd>

[Learn: Use deployment tags to intervene in the deployment process](https://github.com/ilikeyi/YiSuite/tree/main/_Learn/Deployment.Tag)
</dl></dd></ul>

<br>
<ul>6. Change the location of user folders: Desktop, Documents, Downloads, Music, Pictures, Videos</ul>
<ul>7. Add desktop icons: Computer, Recycle Bin, User's Files, Control Panel, Network, God Mode, Internet Explorer</ul>


<ul>
   <p>8. Optimization</p>
   <dl>
      <dd>
         <p>8.1. System class</p>
         <dl><dd>Disable TPM installation checks, disabling TPM prevents you from upgrading the system, reserve space, hibernate, power mode: high performance, "This application is preventing a shutdown or restart" screen, NumLock key automatically lights up after power on, User Account Control (UAC): Never notify me, Smart Screen app and file check, SmartScreen downloaded files marked as unsafe, Easy access to keyboard stuff, Automatic maintenance plan, Customer experience improvement plan, Disk defragmentation plan, Program Compatibility Assistant, Optimize visual animation effects , Windows Error Recovery, DEP and PAE, Auto-repair after power outage, Infinite maximum password age, Reduce the number of processors used by RAM, Disable Storage Sense, Delivery Optimization, Photo Preview, "Windows Protects Your PC" dialog box, bug reporting, F8 boot menu option, SSD, memory compression, prefetch preboot</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.2.	Optimize network</p>
         <dl><dd>Restore IE settings proxy does not take effect, IE automatically checks settings, network discovery file and printer sharing, turn off the network adapter to save power, Internet Protocol version 6 (TCP/IPv6) component, QOS service, network tuning function, ECN function</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.3.	File explorer</p>
         <dl><dd>Use separate process for each Explorer window, restart app after login, project checkbox, thumbnail cache removal, set default Explorer view to: This PC, Aero Shake Shake to lowest functionality, show known Extensions for file types, Common file type security warnings, Set up file transfer dialog: Details, Turn on Show all folders in the navigation pane, Autoplay, Autorun all drives, Show recently used in Quick Access Files, "Quick Access" and display frequently used folders, delete shortcut arrows and suffixes, delete from this PC: Desktop, Documents, Downloads, Music, Pictures, Videos, 3D Objects</dl></dd>
         </dd>

<br>
      <dd>
         <p>8.4.	Context menu</p>
         <dl><dd>Enable classic style, take ownership, add copy path, add 15 file selection limit</dl></dd>
      </dd>

<br>
      <dd>8.5. Close Notification Center: Fully, Partially</dd>
      <dd>8.6. Set system paging size: 8G, 16G</dd>
      <dd>
         <p>8.7. Personalise</p>
         <dl><dd>Apply dark colors to: Apps, System, Transparency, Snap Assist</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.8. Start menu and taskbar</p>
         <dl><dd>Set taskbar to: center, left aligned, hide taskbar widget icon, delete widget, Microsoft Teams auto-start, Microsoft Teams chat icon, Bing search in start menu, hide from me in Settings app Recommended content, Advice on how to set up your device, Set up the taskbar: Show search icon, Merge taskbar buttons: Never, Notification area: Always show all icons, Hide Cortana button on taskbar, Hide task view button on tasks</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.9. Game</p>
         <dl><dd>Xbox Game Bar, Xbox Game Bar Tips, Xbox Game Mode, Xbox DVR</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.10. Privacy setting</p>
         <dl><dd>Diagnostics Track scheduled tasks, send voice, ink, and typing samples to MS, send contacts to MS, let websites provide relevant content for this book by accessing my language list, let apps use my advertising ID for cross-app experiences, location awareness Printing, settings sync, inking and typing personalization, sharing information with unpaired devices, location sensors, Windows Hello biometrics, compatibility telemetry, diagnostic data, tailored experiences, feedback notifications, location tracking, connected user experience and Telemetry, background access to default apps, submit Windows Defend findings to MS, timeline time, collect activity history</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.11. Other:</p>
         <dl><dd>Enable 3389 Remote Desktop, open SMB file sharing</dl></dd>
      </dd>

<br>
      <dd>
         <p>8.12. Cleanup: </p>
         <dl><dd>Send to, syslog, disk cleanup, WinSxS</dl></dd>
      </dd>
   </dl>
</ul>

<br>
<ul>
   <p>9. Optimize services</p>
   <dl>
      <dd>9.1. Turn off Windows Update</dd>
      <dd>9.2. Microsoft Defender Firewall</dd>
      <dd>9.3. Delete widget</dd>
   </dl>
</ul>

<br>
<ul>
   <p>10. Delete UWP app</p>
   <dl>
      <dd>Block app reinstallation, Hide Recommend me content in the Settings app, Turn off Microsoft Store automatic downloads, Block installation of Suggested Apps, Suggestions on how to set up your device</dd>
   </dl>
</ul>

<br>

## License

Distributed under the MIT License. See `LICENSE` for more information.


## Contact

Yi - [https://fengyi.tel](https://fengyi.tel) - 775159955@qq.com

Project Link: [https://github.com/ilikeyi/YiSuite](https://github.com/ilikeyi/YiSuite)
