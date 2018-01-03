function GetIdleTime
{
<#
.SYNOPSIS
Quote from http://www.pstips.net/detec-idle-time.html
#>
Add-Type @'
using System;
using System.Runtime.InteropServices;
namespace Win32_API
{
    internal struct LASTINPUTINFO 
    {
        public uint cbSize;
        public uint dwTime;
    }
    /// <summary>
    /// Summary description for Win32.
    /// </summary>
    public class Win32
    {
        [DllImport("User32.dll")]
        public static extern bool LockWorkStation();
        [DllImport("User32.dll")]
        private static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);        

        [DllImport("Kernel32.dll")]
        private static extern uint GetLastError();

        public static uint GetIdleTime()
        {
            LASTINPUTINFO lastInPut = new LASTINPUTINFO();
            lastInPut.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(lastInPut);
            GetLastInputInfo(ref lastInPut);

            return ( (uint)Environment.TickCount - lastInPut.dwTime);
        }
        public static long GetTickCount()
        {
            return Environment.TickCount;
        }
        public static long GetLastInputTime()
        {
            LASTINPUTINFO lastInPut = new LASTINPUTINFO();
            lastInPut.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(lastInPut);
            if (!GetLastInputInfo(ref lastInPut))
            {
                throw new Exception(GetLastError().ToString());
            }                           
            return lastInPut.dwTime;
        }
    }
}
'@
[Win32_API.Win32]::GetIdleTime()/1000
}
GetIdleTime
