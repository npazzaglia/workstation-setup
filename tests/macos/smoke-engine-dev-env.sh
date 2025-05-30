#!/usr/bin/env bash
set -euo pipefail

# Root and log directory setup
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DIR="$ROOT_DIR/logs"

# Clean out previous logs
rm -rf "$LOG_DIR"
mkdir -p "$LOG_DIR"

# Run the setup script in dry-run mode
echo "Running setup-macos.sh --dry-run..."
chmod +x "$ROOT_DIR/scripts/setup-macos.sh"
bash "$ROOT_DIR/scripts/setup-macos.sh" --dry-run

# Assertions: verify the dry-run log contains the expected entries
echo "Verifying dry-run output in $LOG_DIR/setup.log..."

grep -Fq "=== Phase: apps ===" "$LOG_DIR/setup.log" || { echo "Missing phase header 'apps'"; exit 1; }
grep -Fq "Processing iterm2..." "$LOG_DIR/setup.log" || { echo "Did not process iterm2"; exit 1; }
grep -Fq "[dry-run] Would run: brew install --cask iterm2" "$LOG_DIR/setup.log" || { echo "Unexpected install command"; exit 1; }

echo "smoke-engine-dev-env: PASS"