# ============================================================
# 生态科档案 (Ecology Section Archive) 启动脚本
# 用法: ./start.ps1        桌面应用模式 (默认, 真正的程序窗口)
#       ./start.ps1 -Web   浏览器预览模式 (仅 UI 外壳, 功能受限)
# ============================================================

param(
    [switch]$Web
)

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
Set-Location $root

# Rust 环境位于 E 盘（C 盘空间不足），确保当前会话可用
$env:RUSTUP_HOME = "E:\rust\.rustup"
$env:CARGO_HOME = "E:\rust\.cargo"
if ($env:Path -notlike "*E:\rust\.cargo\bin*") {
    $env:Path = "E:\rust\.cargo\bin;$env:Path"
}

# 检查 Node 环境
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[错误] 未找到 Node.js，请先安装: https://nodejs.org" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

# 依赖检查：缺失则自动安装
if (-not (Test-Path (Join-Path $root "node_modules"))) {
    Write-Host "[准备] 安装前端依赖 (npm install) ..." -ForegroundColor Green
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[错误] 依赖安装失败" -ForegroundColor Red
        Read-Host "按回车键退出"
        exit 1
    }
}

if (-not $Web) {
    # ── 桌面应用模式 (默认) ──
    if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) {
        Write-Host "[错误] 未找到 cargo (Rust 工具链)" -ForegroundColor Red
        Write-Host "  请先安装 Rust: https://rustup.rs" -ForegroundColor Yellow
        Read-Host "按回车键退出"
        exit 1
    }

    Write-Host "[启动] 生态科档案 · 莱茵生命生态科终端 ..." -ForegroundColor Cyan
    Write-Host "  首次编译 Rust 需较长时间，请耐心等待。" -ForegroundColor Yellow
    Write-Host "  关闭程序窗口即退出。" -ForegroundColor Gray
    Write-Host ""

    npx tauri dev
    exit $LASTEXITCODE
}

# ── 浏览器预览模式 (功能受限) ──
$port = 1420
$url = "http://localhost:$port/"
Write-Host "[提示] 浏览器模式下 Tauri API 不可用，仅能预览界面外壳。" -ForegroundColor Yellow

# 若端口已被占用（服务器已在运行），直接打开浏览器
$inUse = $false
try {
    Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction Stop | Out-Null
    $inUse = $true
} catch { }

if ($inUse) {
    Write-Host "  端口 $port 已有服务在运行，直接打开浏览器。" -ForegroundColor Yellow
    Start-Process $url
    exit 0
}

# 后台启动 Vite
$server = Start-Process -FilePath "cmd.exe" `
    -ArgumentList "/c", "npm run dev" `
    -WorkingDirectory $root `
    -WindowStyle Minimized -PassThru

# 等待服务器就绪（最多 60 秒）
Write-Host "  等待 http://localhost:$port 就绪 ..." -ForegroundColor Gray
$ready = $false
for ($i = 0; $i -lt 60; $i++) {
    if ($server.HasExited) { break }
    try {
        $resp = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 2
        if ($resp.StatusCode -eq 200) { $ready = $true; break }
    } catch { Start-Sleep -Seconds 1 }
}

if (-not $ready) {
    Write-Host "[错误] 服务器启动超时，请检查 npm run dev 输出" -ForegroundColor Red
    if (-not $server.HasExited) { Stop-Process -Id $server.Id -Force -ErrorAction SilentlyContinue }
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "  打开浏览器 ..." -ForegroundColor Green
Start-Process $url

Write-Host ""
Write-Host "  预览地址: $url" -ForegroundColor Cyan
Write-Host "  按回车键停止服务器并退出。" -ForegroundColor Yellow
Read-Host | Out-Null

# 停止 Vite 及其子进程
if (-not $server.HasExited) {
    & taskkill /PID $server.Id /T /F 2>$null | Out-Null
}
Write-Host "服务器已停止。" -ForegroundColor Green
