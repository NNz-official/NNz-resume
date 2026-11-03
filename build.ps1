param([switch]$Watch)
$ErrorActionPreference = 'Stop'
$resumeRoot = $PSScriptRoot
$typstCommand = Get-Command typst -ErrorAction SilentlyContinue
if ($typstCommand) {
    $compilerPath = $typstCommand.Source
} else {
    $wingetRoot = Join-Path $env:LOCALAPPDATA 'Microsoft/WinGet/Packages'
    $installedCompiler = Get-ChildItem -LiteralPath $wingetRoot -Directory -Filter 'Typst.Typst_*' -ErrorAction SilentlyContinue |
        ForEach-Object { Get-ChildItem -LiteralPath $_.FullName -Recurse -Filter typst.exe } |
        Select-Object -First 1
    $compilerPath = if ($installedCompiler) { $installedCompiler.FullName } else {
        Join-Path $resumeRoot '.tools/typst-x86_64-pc-windows-msvc/typst.exe'
    }
    if (-not (Test-Path -LiteralPath $compilerPath)) {
        throw 'Typst not found. Install: winget install --id Typst.Typst -e ; then reopen PowerShell.'
    }
}
$outputDirectory = Join-Path $resumeRoot 'output/pdf'
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
$sourcePath = Join-Path $resumeRoot 'resume.typ'
$outputPath = Join-Path $outputDirectory '周鸿展-简历.pdf'
$operation = if ($Watch) { 'watch' } else { 'compile' }
Write-Host "Typst: $compilerPath"
& $compilerPath $operation --root $resumeRoot $sourcePath $outputPath
if ($LASTEXITCODE -ne 0) { throw "Typst failed: $LASTEXITCODE" }
