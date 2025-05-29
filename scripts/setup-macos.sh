#!/usr/bin/env bash
set -euo pipefail

if [[ "$*" == *"--dry-run"* ]]; then
  echo "🧪 [dry-run] setup-macos.sh executed"
else
  echo "🛠️ Running macOS setup (stub)..."
  # Simulate some logic
  echo "Installing tools for macOS..."
  echo "Applying dotfiles..."
fi
