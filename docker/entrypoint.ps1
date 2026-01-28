param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]] $Remaining
)

$ErrorActionPreference = "Stop"

$bin    = $env:FALCATA_BIN
$config = $env:FALCATA_CONFIG

if (-not (Test-Path $bin)) {
  Write-Host "FATAL: WebServer binary not found: $bin"
  Get-ChildItem "C:\opt\falcata" -Recurse | Select-Object FullName
  exit 1
}

if (-not (Test-Path $config)) {
  Write-Host "WARN: Config not found at $config"
  Write-Host "      You can mount one into C:\opt\falcata\config\config.prod.json"
}

# Optional extra args from env
$extra = @()
if ($env:FALCATA_ARGS -and $env:FALCATA_ARGS.Trim().Length -gt 0) {
  # naive split; if you need quoted parsing, tell me
  $extra = $env:FALCATA_ARGS.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)
}

# If your app expects: WebServer -c <config>
$args = @("-c", $config) + $extra + $Remaining

Write-Host "Starting: $bin $($args -join ' ')"
& $bin @args
exit $LASTEXITCODE
