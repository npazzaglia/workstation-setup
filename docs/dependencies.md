# 📦 Dependencies – workstation-setup

This document lists all external software dependencies used by the setup scripts. It explains where each is installed from, how they're verified, and any special platform notes or user interaction required.

---

## 🧰 Core Dependencies by Category

### 📦 Package Managers

| Tool       | macOS / Linux     | Windows           | Notes                         |
| ---------- | ----------------- | ----------------- | ----------------------------- |
| Homebrew   | ✅ Installed       | ❌ N/A             | Primary CLI tool manager      |
| apt        | Ubuntu-based only | ❌ N/A             | Used for fallback installs    |
| Chocolatey | ❌ N/A             | ✅ Installed       | Used for CLI and GUI packages |
| winget     | ❌ N/A             | Optional fallback | Windows 11+ native pkg mgr    |

---

### ⚙️ CLI Utilities

| Tool   | Purpose                  | Verified | Install Source |
| ------ | ------------------------ | -------- | -------------- |
| `git`  | Version control          | ✅        | brew / choco   |
| `curl` | Script and API downloads | ✅        | brew / choco   |
| `jq`   | JSON processing          | ✅        | brew / choco   |
| `fzf`  | Fuzzy finding in CLI     | ✅        | brew / choco   |
| `htop` | Process monitor          | ✅        | brew / choco   |

---

### 🧪 Language Toolchains

| Tool          | Version Managed By | Verified | Install Source |
| ------------- | ------------------ | -------- | -------------- |
| Python        | `pyenv`            | ✅        | brew / choco   |
| Node.js       | `nvm`              | ✅        | curl script    |
| Go (optional) | `asdf` or direct   | ⬜️       | brew / choco   |
| Ruby (opt)    | `rbenv`            | ⬜️       | brew / choco   |

---

### 💻 IDEs and Editors

| Tool    | Platform        | GUI? | Install Source  | Notes                            |
| ------- | --------------- | ---- | --------------- | -------------------------------- |
| VS Code | All             | ✅    | brew / choco    | Optional CLI `code` install step |
| Cursor  | macOS / Windows | ✅    | direct download | May require manual install steps |

---

### 🔐 Secrets Management (Optional)

| Tool         | Purpose           | Source     | Notes                             |
| ------------ | ----------------- | ---------- | --------------------------------- |
| `op` CLI     | 1Password Secrets | brew/choco | Requires login + session unlocked |
| `pass` (opt) | GPG-based secrets | brew       | Not used by default               |

---

### 🪟 Optional GUI Applications

| App              | Platform        | Install Method            | Notes                                       |
| ---------------- | --------------- | ------------------------- | ------------------------------------------- |
| Neo4j Desktop    | macOS / Windows | manual or brew cask       | Optional data tooling; not script-mandatory |
| CommanderOne Pro | macOS           | manual (App Store or dmg) | Licensed app, install manually              |
| Windsurf         | macOS           | manual                    | Niche tool, not included in automation      |

---

## 📋 Verification and Checksums

* All downloads via `curl` should be piped through checksum verification (TODO)
* GUI apps (e.g. Cursor) must have source URL and optional SHA validation
* Validate install success by checking binary in `$PATH`

---

## ⚠️ Interaction Requirements

| Component     | Requires Manual Step? | Notes                                   |
| ------------- | --------------------- | --------------------------------------- |
| 1Password CLI | ✅                     | User must unlock session or re-auth     |
| Cursor        | ✅                     | May require GUI confirmation on install |
| VS Code       | ❌                     | Fully scripted                          |
| CommanderOne  | ✅                     | GUI-only with no CLI automation         |
| Neo4j Desktop | ✅                     | May require manual login/license setup  |

---

## 📂 Related Files

* `packages/Brewfile`
* `packages/choco-install.ps1`
* `scripts/setup.sh`, `setup.ps1`
* `configs/dev_env.yml`

---

## 🔧 Future Work

* Add checksum validation to all curl-installers
* Unify version pinning schema across `dev_env.yml`
* Add auto-verification for shell integrations (e.g. `zsh` plugins)
