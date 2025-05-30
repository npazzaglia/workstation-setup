#!/usr/bin/env bash
set -euo pipefail

# Smoke test: skip-logging for disabled & OS-mismatch
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DEV_ENV_YAML="$ROOT_DIR/configs/dev-env.yml"
LOG_DIR="$ROOT_DIR/logs"

# Backup original manifest
cp "$DEV_ENV_YAML" "$DEV_ENV_YAML.bak"

# Overwrite with a test manifest
cat > "$DEV_ENV_YAML" <<EOF
tools:
  - name: "iterm2"
    category: "terminals"
    phase: "apps"
    installer: "cask"
    os: [macos]
    enabled: true
    manual: false
    version: ""
    depends_on: []
  - name: "foo"
    category: "apps"
    phase: "apps"
    installer: "formula"
    os: [macos]
    enabled: false
    manual: false
    version: ""
    depends_on: []
  - name: "bar"
    category: "apps"
    phase: "apps"
    installer: "formula"
    os: [linux]
    enabled: true
    manual: false
    version: ""
    depends_on: []
EOF

# Clear logs
rm -rf "$LOG_DIR"
mkdir -p "$LOG_DIR"

# Run dry-run
echo "Running setup-macos.sh --dry-run..."
"$ROOT_DIR/scripts/setup-macos.sh" --dry-run

# Assertions
grep -Fq "[dry-run] Skipping foo (disabled or not macos)" "$LOG_DIR/setup.log" || { echo "❌ Missing skip for foo"; exit 1; }
grep -Fq "[dry-run] Skipping bar (disabled or not macos)" "$LOG_DIR/setup.log" || { echo "❌ Missing skip for bar"; exit 1; }
grep -Fq "Processing iterm2..." "$LOG_DIR/setup.log"   || { echo "❌ iterm2 was not processed"; exit 1; }

# Restore original manifest
mv "$DEV_ENV_YAML.bak" "$DEV_ENV_YAML"

echo "smoke-engine-skip-logging: PASS"