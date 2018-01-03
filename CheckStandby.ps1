function Get-DelegateType {
  Param (
    [OutputType([Type])]
  [Parameter( Position = 0)]
  [Type[]]
  $Parameters = (New-Object Type[](0)),
    [Parameter( Position = 1 )]
  [Type]
  $ReturnType = [Void]
  )
    $Domain = [AppDomain]::CurrentDomain
    $DynAssembly = New-Object Reflection.AssemblyName('ReflectedDelegate')
    $AssemblyBuilder = $Domain.DefineDynamicAssembly($DynAssembly, [System.Reflection.Emit.AssemblyBuilderAccess]::Run)
    $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule('InMemoryModule', $false)
    $TypeBuilder = $ModuleBuilder.DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
    $ConstructorBuilder = $TypeBuilder.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $Parameters)
    $ConstructorBuilder.SetImplementationFlags('Runtime, Managed')
    $MethodBuilder = $TypeBuilder.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $ReturnType, $Parameters)
    $MethodBuilder.SetImplementationFlags('Runtime, Managed')

    $TypeBuilder.CreateType()
}
function Get-ProcAddress {
  Param (
    [OutputType([IntPtr])]
  [Parameter( Position = 0, Mandatory = $True )]
  [String]
  $Module,
    [Parameter( Position = 1, Mandatory = $True )]
  [String]
  $Procedure
    )
    $SystemAssembly = [AppDomain]::CurrentDomain.GetAssemblies() |
    Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }
  $UnsafeNativeMethods = $SystemAssembly.GetType('Microsoft.Win32.UnsafeNativeMethods')
    $GetModuleHandle = $UnsafeNativeMethods.GetMethod('GetModuleHandle')
    $GetProcAddress = $UnsafeNativeMethods.GetMethod('GetProcAddress')
    $Kern32Handle = $GetModuleHandle.Invoke($null, @($Module))
    $tmpPtr = New-Object IntPtr
    $HandleRef = New-Object System.Runtime.InteropServices.HandleRef($tmpPtr, $Kern32Handle)
    $GetProcAddress.Invoke($null, @([Runtime.InteropServices.HandleRef]$HandleRef, $Procedure))
}
$GetForegroundWindowAddr = Get-ProcAddress user32.dll GetForegroundWindow
$GetForegroundWindowDelegate = Get-DelegateType @() ([IntPtr])
$GetForegroundWindow = [Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($GetForegroundWindowAddr, $GetForegroundWindowDelegate)
$hWindow = $GetForegroundWindow.Invoke()
If($hWindow -eq 0)
{
    Write-Host "Standby"
}
Else
{
    Write-Host "Running"
}
