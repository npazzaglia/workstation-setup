Param()

Write-Output "🧪 Smoke test: bootstrap dispatches to setup-windows.ps1"

# Locate repo root and bootstrap script
$RepoRoot    = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Bootstrap   = Join-Path $RepoRoot 'bootstrap'

# Run bootstrap under PowerShell with dry-run
$Output = & pwsh -NoProfile -ExecutionPolicy Bypass $Bootstrap -dry-run 2>&1
if ($LASTEXITCODE -ne 0) {
  Write-Error "❌ bootstrap failed to run"
  Write-Output $Output
  exit 1
}

# Check for expected dispatch message
if ($Output -match "\[dry-run\] setup-windows.ps1 executed") {
  Write-Output "✅ Detected Windows dispatch successful"
} else {
  Write-Error "❌ Expected setup-windows.ps1 dispatch not found in output:"
  Write-Output $Output
  exit 1
}