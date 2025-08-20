#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Smoke test: bootstrap dispatches to setup-macos.sh"

# Ensure bootstrap is executable
chmod +x ../../bootstrap

# Run bootstrap and capture output
BOOTSTRAP_OUT=$(mktemp)
../../bootstrap --dry-run > "$BOOTSTRAP_OUT" 2>&1 || {
  echo "❌ bootstrap failed to run"
  cat "$BOOTSTRAP_OUT"
  exit 1
}

# Check for expected dispatch message
if grep -qF "🧪 [dry-run] setup-macos.sh starting" "$BOOTSTRAP_OUT"; then
  echo "✅ Detected macOS dispatch successful"
else
  echo "❌ Expected setup-macos.sh dispatch not found in output:"
  cat "$BOOTSTRAP_OUT"
  exit 1
fi

# Check for chezmoi step
if grep -q "chezmoi" "$BOOTSTRAP_OUT"; then
  echo "✅ Chezmoi step detected"
else
  echo "❌ Expected chezmoi step not found in output:"
  cat "$BOOTSTRAP_OUT"
  exit 1
fi

rm "$BOOTSTRAP_OUT"

