param(
    [string]$OutFile = (Join-Path $PSScriptRoot "verify_shot.png")
)

Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32Cap {
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT rect);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr hWnd, IntPtr hdcBlt, uint nFlags);
    public struct RECT { public int Left; public int Top; public int Right; public int Bottom; }
}
"@

$proc = Get-Process -Name "ecology-section-archive" -ErrorAction SilentlyContinue |
        Where-Object { $_.MainWindowHandle -ne 0 } | Select-Object -First 1
if (-not $proc) { Write-Host "NO_WINDOW"; exit 1 }

[Win32Cap]::ShowWindow($proc.MainWindowHandle, 9) | Out-Null
Start-Sleep -Milliseconds 400

$rect = New-Object Win32Cap+RECT
[Win32Cap]::GetWindowRect($proc.MainWindowHandle, [ref]$rect) | Out-Null
$w = $rect.Right - $rect.Left
$h = $rect.Bottom - $rect.Top
Write-Host "Window: ${w}x${h}  Title: $($proc.MainWindowTitle)"
if ($w -lt 100 -or $h -lt 100) { Write-Host "BAD_SIZE"; exit 1 }

$bmp = New-Object System.Drawing.Bitmap $w, $h
$g = [System.Drawing.Graphics]::FromImage($bmp)
$hdc = $g.GetHdc()
# PW_RENDERFULLCONTENT = 3, captures occluded windows on Win8.1+
$ok = [Win32Cap]::PrintWindow($proc.MainWindowHandle, $hdc, 3)
$g.ReleaseHdc($hdc)
$g.Dispose()
Write-Host "PrintWindow: $ok"
$bmp.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "Saved: $OutFile"
