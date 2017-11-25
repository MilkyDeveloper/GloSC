; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GloSC"
#define MyAppVersion "1.4.1"
#define MyAppPublisher "Peter Repukat - FlatspotSoftware"
#define MyAppURL "htpp://github.com/Alia5/GloSC"
#define MyAppExeName "GloSC.exe"
#define GloSCLauncherName "GloSC_GameLauncher.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{60BEAC2A-F5B7-4C81-9EB6-CF9FE75E7329}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=installer
LicenseFile=License.txt
InfoBeforeFile=Readme.md
OutputBaseFilename=GloSC-installer_x64
PrivilegesRequired=admin
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "build\x64\Release\GloSC.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\x64\Release\GloSC_GameLauncher.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\x64\Release\SteamTarget.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\SFML-2.4.2-x64\bin\sfml-system-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\SFML-2.4.2-x64\bin\sfml-window-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\SFML-2.4.2-x64\bin\sfml-graphics-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "License.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Qt\5.9\msvc2017_64\bin\Qt5Core.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Qt\5.9\msvc2017_64\bin\Qt5Gui.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Qt\5.9\msvc2017_64\bin\Qt5Widgets.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\Win32Only\Release\EnforceBindingDLL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\Win32Only\Release\Injector.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "qt-license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Readme.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "TargetConfig.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Qt\5.9\msvc2017_64\plugins\platforms\qwindows.dll"; DestDir: "{app}\platforms"; Flags: ignoreversion
Source: "redist\vc_redist_x64.exe"; DestDir: "{app}\redist"; Flags: ignoreversion
Source: "redist\vc_redist_x86.exe"; DestDir: "{app}\redist"; Flags: ignoreversion
Source: "redist\ViGEm\x86\*"; DestDir: "{app}\redist\ViGEm\x86"; Flags: ignoreversion
Source: "redist\ViGEm\x64\*"; DestDir: "{app}\redist\ViGEm\x64"; Flags: ignoreversion
Source: "redist\devcon_x86.exe*"; DestDir: "{app}\redist"; Flags: ignoreversion
Source: "redist\devcon_x64.exe*"; DestDir: "{app}\redist"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\redist\vc_redist_x64.exe"; Parameters: "/quiet /install"; Description: "Installing Redist. packages"; Flags: runascurrentuser
Filename: "{app}\redist\vc_redist_x86.exe"; Parameters: "/quiet /install"; Description: "Installing Redist. packages"; Flags: runascurrentuser
Filename: "{app}\redist\devcon_x64.exe"; Parameters: " remove Root\ViGEmBus "; Description: "Removing ViGEm Driver..."; Flags: runascurrentuser
Filename: "{app}\redist\devcon_x64.exe"; Parameters: " install ""{app}\redist\ViGEm\x64\ViGEmBus.inf"" Root\ViGEmBus "; Description: "Installing ViGEm Driver..."; Flags: runascurrentuser
Filename: "{sys}\schtasks.exe"; Parameters: "/delete /f /tn ""GloSC_GameLauncher"""; Flags: runascurrentuser
Filename: "{app}\{#GloSCLauncherName}"; Description: "Running GameLauncher"; Flags: nowait
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: runascurrentuser nowait postinstall skipifsilent


[Registry]
Root: HKCU; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "GloSC-GameLauncher"; ValueData: """{app}\GloSC_GameLauncher.exe"""; Flags: uninsdeletevalue

[InstallDelete]
Type: files; Name: "{app}"


[UninstallRun]
Filename: "{app}\redist\devcon_x64.exe"; Parameters: "remove Root\ViGEmBus"; Flags: runascurrentuser
Filename: "{sys}\taskkill.exe"; Parameters: "/T /F /IM {#GloSCLauncherName}";
Filename: "{sys}\schtasks.exe"; Parameters: "/delete /f /tn ""GloSC_GameLauncher"""; Flags: runascurrentuser



; Preinstallation Stuff...
[Code]
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: integer;
begin

  // Kill Program and wait for it to terminate
  Exec(ExpandConstant('{sys}\taskkill.exe'), '/T /F /IM {#GloSCLauncherName}', '', SW_SHOW,
     ewWaitUntilTerminated, ResultCode)

  // Proceed Setup
  Result := '';

end;
