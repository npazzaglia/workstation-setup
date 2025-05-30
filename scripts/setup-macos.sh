#!/usr/bin/env bash
set -euo pipefail

# Source shared library functions
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

# Directory setup
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
YAML_FILE="$ROOT_DIR/configs/dev-env.yml"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$LOG_DIR"

# Parse args
DRY_RUN=false
for arg in "$@"; do
  case $arg in
    --dry-run) DRY_RUN=true ;;
  esac
done

# Ensure YAML exists
if [[ ! -f "$YAML_FILE" ]]; then
  echo "Error: $YAML_FILE not found." | tee -a "$LOG_DIR/error.log"
  exit 1
fi

# Start execution
if [[ "$DRY_RUN" == "true" ]]; then
  echo "🧪 [dry-run] setup-macos.sh starting" | tee -a "$LOG_DIR/setup.log"
else
  echo "🛠️ Running macOS setup" | tee -a "$LOG_DIR/setup.log"
fi

bootstrap_prereqs
run_phase_loop

echo "Setup complete." | tee -a "$LOG_DIR/setup.log"
