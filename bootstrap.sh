#!/usr/bin/env bash
# The following line is a trick: In Bash it’s a comment, but in PowerShell it re-invokes the script using pwsh.
# 2>/dev/null; exec pwsh -File "$0" "$@"

# ===========================
# Bash Branch (macOS/Linux)
# ===========================
echo "Detected Bash environment..."
bash ./scripts/setup.sh
exit 0

<#
# ===========================
# PowerShell Branch (Windows)
# ===========================
Write-Host "Detected PowerShell environment..."
.\scripts\setup.ps1
exit
#>
