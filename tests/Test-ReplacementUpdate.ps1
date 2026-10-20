param([Parameter(Mandatory = $true)][string]$Executable)
$ErrorActionPreference = 'Stop'
$tempRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$fixture = Join-Path $tempRoot ('PCL-update-test-' + [guid]::NewGuid().ToString('N'))
if (-not [IO.Path]::GetFullPath($fixture).StartsWith($tempRoot, [StringComparison]::OrdinalIgnoreCase)) { throw 'Fixture is outside temp root.' }
try {
    $package = New-Item -ItemType Directory -Path (Join-Path $fixture 'package')
    $installation = New-Item -ItemType Directory -Path (Join-Path $fixture 'existing install')
    Copy-Item -LiteralPath $Executable -Destination (Join-Path $package 'PCL.exe')
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot '../packaging/Update-PCL.ps1') -Destination $package
    $target = Join-Path $installation 'Original Launcher.exe'
    [IO.File]::WriteAllText($target, 'original-executable-fixture')
    $oldHash = (Get-FileHash -LiteralPath $target).Hash
    $save = Join-Path $installation 'world-save.dat'
    [IO.File]::WriteAllText($save, 'saved-world-fixture')
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $package 'Update-PCL.ps1') -TargetLauncher $target
    if ($LASTEXITCODE -ne 0) { throw 'Replacement updater failed.' }
    if ((Get-FileHash -LiteralPath $target).Hash -ne (Get-FileHash -LiteralPath $Executable).Hash) { throw 'Replacement binary differs from release.' }
    $backups = @(Get-ChildItem -LiteralPath $installation -Filter '*.backup-*.exe')
    if ($backups.Count -ne 1 -or (Get-FileHash -LiteralPath $backups[0].FullName).Hash -ne $oldHash) { throw 'Original executable backup is missing or changed.' }
    if ([IO.File]::ReadAllText($save) -ne 'saved-world-fixture') { throw 'Existing data was changed.' }
    Copy-Item -LiteralPath $backups[0].FullName -Destination $target -Force
    if ((Get-FileHash -LiteralPath $target).Hash -ne $oldHash) { throw 'Backup cannot restore the original executable.' }
    Write-Output 'PASS: replacement, exact original backup, data preservation, and rollback in isolated fixture.'
} finally {
    if ([IO.Path]::GetFullPath($fixture).StartsWith($tempRoot, [StringComparison]::OrdinalIgnoreCase) -and (Test-Path -LiteralPath $fixture)) {
        Remove-Item -LiteralPath $fixture -Recurse -Force
    }
}
