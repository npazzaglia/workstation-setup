

#!/usr/bin/env bash
set -euo pipefail

# Smoke test: malformed YAML fallback
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
YAML_FILE="$ROOT_DIR/configs/dev-env.yml"
BACKUP_FILE="$YAML_FILE.bak"

# Backup and write broken YAML
cp "$YAML_FILE" "$BACKUP_FILE"
cat > "$YAML_FILE" <<EOF
tools:
  - name: "iterm2"
    category: "terminals"
    phase "apps"     # missing colon after phase
    installer: "cask"
    os: [macos]
    enabled: true
EOF

# Clean logs
rm -rf "$ROOT_DIR/logs"
mkdir -p "$ROOT_DIR/logs"

# Run setup with malformed YAML and capture output
set +e
OUTPUT=$("$ROOT_DIR/scripts/setup-macos.sh" --dry-run 2>&1)
EXIT_CODE=$?
set -e

# Assertions
if [[ $EXIT_CODE -eq 0 ]]; then
  echo "❌ Expected non-zero exit due to malformed YAML"
  # Restore YAML before exiting
  mv "$BACKUP_FILE" "$YAML_FILE"
  exit 1
fi

echo "$OUTPUT" | grep -Fq "Error: failed to parse dev-env.yml" || {
  echo "❌ Expected parse error message; got:"
  echo "$OUTPUT"
  mv "$BACKUP_FILE" "$YAML_FILE"
  exit 1
}

# Restore original YAML
mv "$BACKUP_FILE" "$YAML_FILE"
echo "smoke-engine-bad-yaml: PASS"