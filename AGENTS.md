---
name: "Codex Contribution Guide"
description: "Guidelines for AI agents (Codex, Cursor, Claude Code) contributing to the workstation-setup repository"
lastUpdated: "2025-08-18"
versionScope: "v0.3.x (macOS baseline); v0.4.x planned extensions"
owner: "Nick Pazzaglia"
---

**Purpose:** Tell AI coding agents exactly how to operate in this repo so edits are safe, minimal, and follow project rules.
**Scope:** macOS is golden path; Linux/Windows present (bootstrap + stubs/tests).
**Core Principle:** Idempotent, declarative setup driven by YAML, tested by smoke scripts, with logs and dry-runs.

## Repository Map (authoritative)

```
bootstrap                     # Cross‑platform entrypoint (Bash / hands off PowerShell)
scripts/
  lib.sh                      # Shared helpers (bootstrap_prereqs, install_tool, run_phase_loop)
  setup-macos.sh              # macOS engine (primary)
  setup-linux.sh              # Linux stub/engine (mirrors macOS structure)
  setup-windows.ps1           # Windows engine (PowerShell)
configs/
  dev-env.yml                 # Declarative tool list (name, manager, manual, platform)
dotfiles/                     # Chezmoi-managed home files
  dot_zshrc  dot_gitconfig    # Shell and Git templates
  aliases.sh aliases.ps1      # Shared alias definitions
  dot_config/Code/User/settings.json # VS Code settings
tests/
  macos/
    smoke-bootstrap.sh
    smoke-engine-dev-env.sh
    smoke-engine-bad-yaml.sh
    smoke-engine-skip-logging.sh
  linux/
    smoke-bootstrap.sh
  windows/
    smoke-bootstrap.ps1
logs/                         # setup.log / error.log (created at runtime)
```

## Editing Rules (do this, not that)

1. **Idempotency first.** Any script change must be safe on repeat runs.
2. **Single source of truth:** Extend `configs/dev-env.yml` (or add new YAML) rather than hardcoding tool lists in scripts.
3. **Shared logic → `lib.sh`.** If two OS scripts need it, put it in `lib.sh`.
4. **macOS leads.** Implement on macOS, mirror structure for Linux/Windows, and add corresponding smoke tests.
5. **Dry‑run friendly.** All execution paths must respect `--dry-run` and log to `logs/`.
6. **Surgical diffs.** Modify the smallest possible region. Preserve comments—they are documentation.

## How to Add/Change Things

### A) Add a new tool (Homebrew example)

1. Edit `configs/dev-env.yml` and append:

   ```yaml
   - name: jq
     manager: homebrew
     manual: false
     platform: macos
   ```

2. Ensure `run_phase_loop` in `lib.sh` already handles the `manager` you used (homebrew/cask/etc). If not, extend it **in `lib.sh`**.

3. Add/extend smoke test:

   * Update `tests/macos/smoke-engine-dev-env.sh` to assert the dry-run prints `Processing jq...` and `brew install jq`.

4. Run locally:

   * `bash scripts/setup-macos.sh --dry-run` → verify expected lines in output.

5. Update `CHANGELOG.md`.

### B) Add a new phase or manager

* Extend `lib.sh` only. OS scripts should just call `run_phase_loop`.
* Add failing test first (e.g., new `tests/macos/smoke-engine-<feature>.sh`).
* Keep behavior visible via echo’d checkpoints (assertable text).

### C) Adjust bootstrap routing

* Edit `bootstrap` (Bash path + PowerShell path). Keep OS case branches simple; don’t add logic here if it can live in engines.

## Tests: What agents must keep green

* `tests/macos/smoke-bootstrap.sh` must detect the macOS dispatch text:

  * Looks for `🧪 [dry-run] setup-macos.sh executed` (or the logged start line).
* Engine tests rely on **string assertions**, never real installs. Examples:

  * `smoke-engine-dev-env.sh` expects “Processing <tool>…” and `[dry-run] Would run: brew install …`
  * `smoke-engine-bad-yaml.sh` should fail fast with a clear message when YAML is malformed.
  * `smoke-engine-skip-logging.sh` verifies skip-logging behavior for disabled/OS-mismatch tools.

**When you change logging text, update tests accordingly.**

## Logging & Flags

* `--dry-run` sets `DRY_RUN=true` and prints commands rather than running them.
* All engines create `logs/setup.log` and `logs/error.log`.
* `bootstrap_prereqs` handles Homebrew and `yq`; in dry-run it prints a skip line.

## Commit/PR Conventions

* **Conventional Commits** format:

  ```
  feat(engine): install jq from dev-env.yml
  fix(lib): handle unknown manager with explicit error
  test(macos): assert jq install in dry-run
  docs(agents): add tool-add recipe
  ```

* Keep PRs small; link to `CHANGELOG.md` entry.

* Never introduce new tools without updating YAML + tests.

## Don’ts (hard rules)

* Don’t hardcode tool lists in scripts—**use YAML**.
* Don’t duplicate logic across `setup-*` scripts—**use `lib.sh`**.
* Don’t break dry‑run output stability used by tests without updating the tests.
* Don’t commit secrets, tokens, or machine‑specific paths.

## Quality Gate (agent checklist)

* [ ] Change is idempotent and respects `--dry-run`.
* [ ] Updated/added smoke test(s) pass locally.
* [ ] Logs show clear, greppable checkpoints.
* [ ] Shared logic lives in `lib.sh`; OS scripts remain thin.
* [ ] `CHANGELOG.md` updated; commit follows Conventional Commits.
* [ ] README instructions still accurate (bootstrap and platform notes).

## Roadmap Hints for Agents

* v0.3.x: macOS engine baseline (current).
* v0.4.x: expand Linux parity using same YAML + `lib.sh` dispatch.
* v0.5.x: flesh out Windows engine (parity where practical).
* Future: integrate `chezmoi`/`mackup` behind feature flags—still declarative, still testable via dry-run.

## Troubleshooting Edits

* If tests fail on string mismatch: **prefer changing tests** to assert stable, high-signal lines you control (e.g., “Processing <name>…”) rather than brittle full commands.
* If YAML parsing fails: add explicit error with filename + line hint; ensure test expects non‑zero exit and helpful message.

---
