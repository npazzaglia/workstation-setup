#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Smoke test: bootstrap dispatches to setup-linux.sh"

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
if grep -qF "[dry-run] setup-linux.sh executed" "$BOOTSTRAP_OUT"; then
  echo "✅ Detected Linux dispatch successful"
else
  echo "❌ Expected setup-linux.sh dispatch not found in output:"
  cat "$BOOTSTRAP_OUT"
  exit 1
fi

rm "$BOOTSTRAP_OUT"