param([string]$TargetLauncher)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Windows.Forms
if ([string]::IsNullOrWhiteSpace($TargetLauncher)) {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = '选择要更新的原 PCL 启动器（请先关闭启动器）'
    $dialog.Filter = 'PCL 启动器 (*.exe)|*.exe'
    if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { exit 0 }
    $TargetLauncher = $dialog.FileName
    $dialog.Dispose()
}
$target = (Resolve-Path -LiteralPath $TargetLauncher).Path
$source = Join-Path $PSScriptRoot 'PCL.exe'
if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw '更新包缺少 PCL.exe，请完整解压后重试。' }
if ([IO.Path]::GetExtension($target) -ne '.exe') { throw '请选择原启动器 EXE。' }
if ([StringComparer]::OrdinalIgnoreCase.Equals($target, [IO.Path]::GetFullPath($source))) { throw '请选择原启动器，而不是更新包中的 PCL.exe。' }
$running = Get-Process | Where-Object { try { $_.Path -and [StringComparer]::OrdinalIgnoreCase.Equals($_.Path, $target) } catch { $false } }
if ($running) { throw '原启动器仍在运行，请关闭后重试。' }
$backup = $target + '.backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '-' + [guid]::NewGuid().ToString('N') + '.exe'
$staged = $target + '.update-' + [guid]::NewGuid().ToString('N') + '.tmp'
try {
    [IO.File]::Copy($source, $staged, $false)
    if ((Get-FileHash -LiteralPath $staged).Hash -ne (Get-FileHash -LiteralPath $source).Hash) { throw '更新文件校验失败，原启动器未修改。' }
    [IO.File]::Replace($staged, $target, $backup)
    Write-Output ('更新完成：' + $target)
    Write-Output ('原启动器备份：' + $backup)
    Write-Output '游戏目录、存档和配置文件均未删除。'
} finally {
    if (Test-Path -LiteralPath $staged) { Remove-Item -LiteralPath $staged -Force }
}
