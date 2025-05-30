#!/usr/bin/env bash
set -euo pipefail

# Bootstrap prerequisites: Homebrew and yq
bootstrap_prereqs() {
  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "🧪 [dry-run] Skipping bootstrap_prereqs (Homebrew & yq)" | tee -a "$LOG_DIR/setup.log"
    return
  fi
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
  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[dry-run] Would run: $cmd" | tee -a "$LOG_DIR/setup.log"
  else
    eval "$cmd" 2>>"$LOG_DIR/error.log" | tee -a "$LOG_DIR/setup.log"
  fi
}

# Run the per-phase iteration loop
run_phase_loop() {
  # Validate YAML syntax
  if ! yq eval '.tools' "$YAML_FILE" > /dev/null 2>&1; then
    echo "Error: failed to parse dev-env.yml" >&2
    exit 1
  fi

  local PHASES=(prerequisites packages casks apps postinstall)
  for phase in "${PHASES[@]}"; do
    echo "=== Phase: $phase ===" | tee -a "$LOG_DIR/setup.log"
    # Gather all tools for this phase
    while IFS= read -r name; do
      # Determine flags and os support
      enabled=$(yq eval -r ".tools[] | select(.name == \"${name}\" and .phase == \"${phase}\") | .enabled" "$YAML_FILE")
      manual=$(yq eval -r ".tools[] | select(.name == \"${name}\" and .phase == \"${phase}\") | .manual" "$YAML_FILE")
      os_match=$(yq eval -r ".tools[] | select(.name == \"${name}\" and .phase == \"${phase}\") | .os[] | select(. == \"macos\")" "$YAML_FILE" || echo "")
      if [[ "$enabled" != "true" ]] || [[ "$manual" == "true" ]] || [[ -z "$os_match" ]]; then
        echo "[dry-run] Skipping ${name} (disabled or not macos)" | tee -a "$LOG_DIR/setup.log"
        continue
      fi
      installer=$(yq eval -r ".tools[] | select(.name == \"${name}\" and .phase == \"${phase}\" and .enabled and (.manual == false) and (.os[] == \"macos\")) | .installer" "$YAML_FILE")
      case "$installer" in
        formula) cmd="brew install ${name}" ;;
        cask)    cmd="brew install --cask ${name}" ;;
        *)
          echo "Skipping ${name}: unknown installer type '${installer}'" | tee -a "$LOG_DIR/setup.log"
          continue
          ;;
      esac
      install_tool "$name" "$cmd"
    done < <(yq eval -r ".tools[] | select(.phase == \"${phase}\") | .name" "$YAML_FILE")
  done
}
