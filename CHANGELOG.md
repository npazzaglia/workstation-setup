# 📦 Changelog – workstation-setup

All notable changes to this project will be documented in this file.

---

## \[0.2.0.0] – 2025-05-30

### 🆕 Added

* Polyglot `bootstrap` script to detect OS and delegate to platform-specific setup
* Stubbed setup scripts:

  * `setup-macos.sh` with dry-run logic
  * `setup-linux.sh` with dry-run logic
  * `setup-windows.ps1` placeholder for Windows
* Smoke tests:

  * `tests/macos/smoke-bootstrap.sh`
  * `tests/linux/smoke-bootstrap.sh`
  * `tests/windows/smoke-bootstrap.ps1`
* Updated `/tests/README.md` with full structure, test types, and execution examples

### ✅ Status

* All entrypoint routing logic complete
* Ready for v0.3 to implement YAML-driven setup execution and tool installs

---

## \[0.1.0.0] – 2025-05-29

### 🆕 Added

* Full documentation structure under `/docs/`

  * `overview.md`, `troubleshooting.md`, `testing.md`, `dependencies.md`
  * `/docs/modules/*.md` for core tools (e.g. git, docker, vscode, zsh, etc.)
* `README.md` with:

  * Cross-platform quickstart
  * Bootstrap overview + install flow
  * Mermaid architecture diagram
* `dev_env.yml` as unified source of truth for tools, versions, and install modes
* Two ADRs:

  * `bootstrap` logic design
  * `dev_env.yml` config model

### 🔁 Changed

* Deprecated `architecture-flowchart.md` (merged into `overview.md`)

### ✅ Status

* All documentation complete
* `v0.2.0.0` will begin implementation of YAML-driven setup engine in `setup.sh` and `setup.ps1`

---
