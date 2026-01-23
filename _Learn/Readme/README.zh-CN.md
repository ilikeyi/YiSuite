快速下载指南
-

以管理员身份打开“Terminal”或“PowerShell ISE”，将以下命令行粘贴到“Terminal”对话框，按回车键（Enter）后开始运行；

<br>

以管理员身份打开“Terminal”或“PowerShell ISE”，设置 PowerShell 执行策略：绕过，PS 命令行：
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
```

<br>

a) 优先从 Github 节点下载
```
curl https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -o get.ps1; .\get.ps1;
wget https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -O get.ps1; .\get.ps1;
iwr https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -out get.ps1; .\get.ps1;
Invoke-WebRequest https://github.com/ilikeyi/YiSuite/raw/main/get.ps1 -OutFile get.ps1; .\get.ps1;
```

<br>

b) 优先从 Yi 节点下载
```
curl https://fengyi.tel/ys -o get.ps1; .\get.ps1;
wget https://fengyi.tel/ys -O get.ps1; .\get.ps1;
iwr https://fengyi.tel/ys -out get.ps1; .\get.ps1;
Invoke-WebRequest https://fengyi.tel/ys -OutFile get.ps1; .\get.ps1;
```

<p>运行安装脚本后，用户可自定义安装界面：指定下载连接、指定安装到、可前往：主程序、创建升级包等。</p>
<p>你可以选择任意一种：交互式体验安装和自定义安装，以适用不同的安装需求，下载时提供了多条不同的命令：Curl、Wget、iwr、Invoke-WebRequest，复制下载连接时，任意复制一条即可。</p>

<br>

学习
 * [如何自定义安装脚本交互式体验](https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Get/Get.zh-CN.pdf)

<br>

Available languages
-
 * [United States - English](https://github.com/ilikeyi/YiSuite)

<br>

Yi's Suite

<h4><pre>主要功能：</pre></h4>
<ul>1. 支持在线升级；</ul>
<ul>2. 修改脚本后支持热刷新；</ul>
<ul>3. 根据描述文件来实现部署规则；</ul>
<ul>4. 自定义创建升级包</ul>
<ul><dl><dd>

[学习：如何创建自定义升级包](https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Custom.upgrade.package/Readme.zh-CN.md)
</dd></dd></ul>

<br>
<ul>
   <p>5. 自定义部署机制</p>
   <dl>
      <dd>4.1. 获取已安装的语言包，自动添加；</dd>
      <dd>4.2. 添加过程中，自动判断 S、SN 版，按规则添加；</dd>
      <dd>4.3. 自动添加机制：
         <dl>
            <dd>
               <p>4.3.1. 遇到单语版时，</p>
               <dl>
                  <dd>仅单语时，自动添加当前语言为全局首选；</dd>
                  <dd>单语版包含多语言包时，
                     <dl>
                        <dd>添加首选语言后，获取等待添加的语言里有 en-US 时，则优先添加为第二语言；</dd>
                        <dd>如果没有 en-US 时，随机选择已安装的语言为第二语言。</dd>
                        <dd>例如单语版本标记：CoreSingleLanguage, CoreCountrySpecific</dd>
                     </dl>
                  </dd>
               </dl>
            </dd>

<br>
            <dd>
               <p>4.3.2. 遇到多语版时，</p>
               <dl>
                  <dd>添加首选语言后，自动添加已安装的所有语言。</dd>
               </dl>
            </dd>
         </dl>
      </dd>
   </dl>
</ul>

<br>
<ul>6. 自定义部署标记</ul>

<ul><dl><dd>

[学习：使用部署标记干预部署过程](https://github.com/ilikeyi/YiSuite/blob/main/_Learn/Deployment.Tag/Readme.zh-CN.md)
</dl></dd></ul>

<br>
<ul>7. 更改用户文件夹的位置：桌面、文档、下载、音乐、图片、视频</ul>
<ul>8. 添加桌面图标：计算机、回收站、用户的文件、控制面板、网络、上帝模式、Internet Explorer</ul>


<ul>
   <p>9. 优化</p>
   <dl>
      <dd>
         <p>9.1. 系统类</p>
         <dl><dd>禁用 TPM 安装检查，禁用 TPM 阻止您升级系统，保留空间，休眠，电源模式：高性能，"此应用正在阻止关机或重新启动" 屏幕，NumLock 键开机后自动亮起，用户账户控制 (UAC)：从不通知我，Smart Screen 应用和文件检查，SmartScreen 下载的文件标记为不安全，轻松访问键盘的东西，自动维护计划，客户体验改善计划，磁盘碎片整理计划，程序兼容性助手，优化视觉动画效果，Windows 错误恢复，DEP 和 PAE，断电后自动修复功能，密码最长使用时间为无限，降低 RAM 使用处理器数量，禁用存储感知，传递优化，照片预览，"Windows 保护了您的 PC" 对话框，错误报告，F8 启动菜单选项，SSD，内存压缩，预取预启动</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.2.	优化网络</p>
         <dl><dd>恢复 IE 设置代理不生效，IE 自动检查设置，网络发现文件和打印机共享，关闭网络适配器以节省电量，Internet 协议版本 6 (TCP/IPv6)组件，QOS 服务，网络调优功能，ECN 功能</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.3.	文件资源管理器</p>
         <dl><dd>每个资源管理器窗口使用单独进程，登录后重启应用，项目复选框，缩略图缓存删除，将默认资源管理器视图设置为：此 PC，Aero Shake 摇一摇降到最低功能，显示 已知文件类型的扩展名，常见文件类型安全警告，设置 文件传输对话框：详细信息，在导航窗格中打开 "显示所有文件夹"，自动播放，自动运行所有驱动器，"快速访问" 中显示最近使用的文件，"快速访问" 和显示常用文件夹，删除快捷方式小箭头和后缀，从这台 PC 上删除：桌面、文档、下载、音乐、图片、视频、3D对象</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.4.	上下文菜单</p>
         <dl><dd>启用经典风格，取得所有权，添加 复制路径，增加 15 个文件选择限制</dl></dd>
      </dd>

<br>
      <dd>9.5. 关闭通知中心：完全、部分</dd>
      <dd>9.6. 设置系统分页大小：8G、16G</dd>

<br>
      <dd>
         <p>9.7. 个性化</p>
         <dl><dd>将深色应用到：应用程序、系统，透明效果，Snap 辅助</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.8. 开始菜单和任务栏</p>
         <dl><dd>将任务栏圣齐设置为：居中、左对齐，隐藏 任务栏小组件图标，删除 小组件，Microsoft Teams 自动启动，Microsoft Teams 聊天图标，开始菜单中的 Bing 搜索，隐藏 在 "设置" 应用中向我推荐内容，有关如何设置设备的建议，设置 任务栏：显示搜索图标，合并任务栏按钮：从不，通知区域：始终显示所有图标，在任务栏上隐藏 Cortana 按钮，在任务上隐藏 任务视图 按钮</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.9. 游戏</p>
         <dl><dd>Xbox 游戏栏，Xbox 游戏栏提示，Xbox 游戏模式，Xbox DVR</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.10. 隐私设置</p>
         <dl><dd>诊断跟踪计划任务，向 MS 发送语音、墨迹和打字样本，向 MS 发送联系人，让网站通过访问我的语言列表来提供本的相关内容，让应用使我的广告 ID 进行跨应用体验，位置感知打印，设置同步，墨迹书写和打字个性化，与未配对设备共享信息，位置传感器，Windows Hello 生物识别，兼容性遥测，诊断数据，量身定制的体验，反馈通知，位置追踪，互联用户体验和遥测，默认应用的后台访问，向 MS 提交 Windows Defend 调查结果，时间轴时间，收集活动历史记录</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.11. 其它：</p>
         <dl><dd>启用 3389 远程桌面，打开 SMB 文件共享</dl></dd>
      </dd>

<br>
      <dd>
         <p>9.12. 清理：</p>
         <dl><dd>发送到，系统日志，磁盘清理，WinSxS</dl></dd>
      </dd>
   </dl>
</ul>



<br>
<ul>
   <p>10. 优化服务</p>
   <dl>
      <dd>10.1. 关闭 Windows 更新</dd>
      <dd>10.2. Microsoft Defender 防火墙</dd>
      <dd>10.3. 删除 OneDrive</dd>
      <dd>10.4. 删除 Edge</dd>
      <dd>10.5. 删除 小组件</dd>
   </dl>
</ul>

<br>
<ul>
   <p>11. 删除 UWP 应用</p>
   <dl>
      <dd>阻止重新安装应用程序，隐藏 在 "设置" 应用中向我推荐内容，关闭 Microsoft Store 自动下载 ，阻止安装“建议的应用程序”，有关如何设置设备的建议</dd>
   </dl>
</ul>

<br>

## License

Distributed under the MIT License. See `LICENSE` for more information.

<br>

## Contact

Yi - [https://fengyi.tel](https://fengyi.tel) - 775159955@qq.com

Project Link: [https://github.com/ilikeyi/YiSuite](https://github.com/ilikeyi/YiSuite)
