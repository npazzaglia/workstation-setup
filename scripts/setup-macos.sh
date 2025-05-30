#!/usr/bin/env bash
set -euo pipefail

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

# Bootstrap prerequisites: Homebrew and yq
bootstrap_prereqs() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..." | tee -a "$LOG_DIR/setup.log"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
      2>>"$LOG_DIR/error.log" | tee -a "$LOG_DIR/setup.log"
  fi
  echo "Updating Homebrew..." | tee -a "$LOG_DIR/setup.log"
  brew update 2>>"$LOG_DIR/error.log" | tee -a "$LOG_DIR/setup.log"

  if ! command -v yq >/dev/null 2>&1; then
    echo "Installing yq for YAML parsing..." | tee -a "$LOG_DIR/setup.log"
    brew install yq 2>>"$LOG_DIR/error.log" | tee -a "$LOG_DIR/setup.log"
  fi
}

# Generic install helper
install_tool() {
  local name="$1"
  local cmd="$2"
  echo "Processing $name..." | tee -a "$LOG_DIR/setup.log"
  if [[ "$DRY_RUN" == "true" ]]; then
    echo "[dry-run] Would run: $cmd" | tee -a "$LOG_DIR/setup.log"
  else
    eval "$cmd" 2>>"$LOG_DIR/error.log" | tee -a "$LOG_DIR/setup.log"
  fi
}

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

# Define the phases and iterate
PHASES=(prerequisites packages casks apps postinstall)
for phase in "${PHASES[@]}"; do
  echo "=== Phase: $phase ===" | tee -a "$LOG_DIR/setup.log"
  # Iterate enabled tools matching this phase and macos
  while IFS= read -r name; do
    installer=$(yq eval -r "
      .tools[]
      | select(.name == \"${name}\" 
        and .phase == \"${phase}\" 
        and .enabled == true 
        and .manual == false 
        and any(.os[]; . == \"macos\"))
      | .installer
    " "$YAML_FILE")
    case "$installer" in
      formula) cmd="brew install ${name}" ;;
      cask)    cmd="brew install --cask ${name}" ;;
      *)
        echo "Skipping ${name}: unknown installer type '${installer}'" | tee -a "$LOG_DIR/setup.log"
        continue
        ;;
    esac
    install_tool "$name" "$cmd"
  done < <(yq eval -r "
    .tools[]
    | select(.phase == \"${phase}\" 
      and .enabled == true 
      and .manual == false 
      and any(.os[]; . == \"macos\"))
    | .name
  " "$YAML_FILE")
done

echo "Setup complete." | tee -a "$LOG_DIR/setup.log"
