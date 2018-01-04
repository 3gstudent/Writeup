Add-Type @'
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
'@ -name “Win32ShowWindowAsync” -namespace Win32API
Function Set-ProcessWindowStyle
{
    param(
     [Parameter(
     Mandatory=$true,
     ValueFromPipeline=$true)]
    [System.Diagnostics.Process]$Process,
    [ValidateSet("Show", "Minimized","Maximized","Hidden")]
    [string]$WindowStyle="Show"
    )
        $WinStateInt = 1
       switch($WindowState)
       {
        "Hidden"       {$WinStateInt =  0}
        "Show"     {$WinStateInt =  1}
        "Maximize"   {$WinStateInt =  3}
        "Minimize"   {$WinStateInt =  6}
        }
    [Win32API.Win32ShowWindowAsync]::ShowWindowAsync($Process.MainWindowHandle,$WindowState)
}
Get-Process iexplore | Set-ProcessWindowStyle -WindowStyle Hidden
