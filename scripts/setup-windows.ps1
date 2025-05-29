Param(
  [switch]$dryRun
)

if ($dryRun) {
  Write-Output "🧪 [dry-run] setup-windows.ps1 executed"
} else {
  Write-Output "🛠️ Running Windows setup (stub)..."
  # Simulate some logic
  Write-Output "Installing tools for Windows..."
  Write-Output "Applying dotfiles..."
}