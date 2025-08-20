#!/usr/bin/env bash
set -euo pipefail

if [[ "$*" == *"--dry-run"* ]]; then
  echo "🧪 [dry-run] setup-linux.sh executed"
else
  echo "🛠️ Running Linux setup (stub)..."
  # Simulate some logic
  echo "Installing tools for Linux..."
fi
