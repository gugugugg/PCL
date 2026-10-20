param(
    [Parameter(Mandatory = $true)][string]$Executable,
    [string]$RegistryPath = ('Software\PCLFork.Tests\' + [guid]::NewGuid().ToString('N')),
    [switch]$VerifyPersisted
)
$ErrorActionPreference = 'Stop'
if (-not $RegistryPath.StartsWith('Software\PCLFork.Tests\')) { throw 'Test registry path is outside the isolated test prefix.' }
$assembly = [Reflection.Assembly]::LoadFile((Resolve-Path -LiteralPath $Executable).Path)
$type = $assembly.GetType('PCL.McDownloadAccess', $true)
$access = [Activator]::CreateInstance($type, [object[]]@($RegistryPath))
$restricted = $type.GetProperty('IsRestricted')
$unlock = $type.GetMethod('TryUnlock')
function Assert-True($value, $message) { if (-not $value) { throw $message } }
if ($VerifyPersisted) {
    Assert-True (-not $restricted.GetValue($access)) 'Unlock did not survive a new process.'
    Write-Output 'PASS: unlock restored in a fresh process.'
    exit 0
}
try {
    Assert-True $restricted.GetValue($access) 'Fresh users must be restricted.'
    foreach ($command in @($null, '', 'help', '11451', '1145140', 'x114514')) {
        Assert-True (-not $unlock.Invoke($access, [object[]]@($command))) 'Invalid command accepted.'
        Assert-True $restricted.GetValue($access) 'Invalid command changed the default restriction.'
    }
    Assert-True $unlock.Invoke($access, [object[]]@(' 114514 ')) 'Valid command did not unlock.'
    Assert-True (-not $restricted.GetValue($access)) 'Download remained restricted.'
    Assert-True $unlock.Invoke($access, [object[]]@('114514')) 'Repeated unlock must succeed.'
    Assert-True (-not $unlock.Invoke($access, [object[]]@('invalid'))) 'Unknown command accepted after unlock.'
    Assert-True (-not $restricted.GetValue($access)) 'Unknown command revoked an existing unlock.'
    $other = [Activator]::CreateInstance($type, [object[]]@($RegistryPath + '\OtherUser'))
    Assert-True $restricted.GetValue($other) 'Unlock leaked to a separate profile.'
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $PSCommandPath -Executable $Executable -RegistryPath $RegistryPath -VerifyPersisted
    if ($LASTEXITCODE -ne 0) { throw 'Fresh-process persistence test failed.' }
    Write-Output 'PASS: default lock, invalid input, permanent unlock, idempotence, and profile isolation.'
} finally {
    [Microsoft.Win32.Registry]::CurrentUser.DeleteSubKeyTree($RegistryPath, $false)
}
