# 🧪 Testing Strategy – workstation-setup

This document outlines the testing and validation strategy for the `workstation-setup` project. It includes manual and automated test flows, GitHub Actions integration, and cross-platform coverage goals.

---

## ✅ Purpose

Ensure that the setup scripts:

* Complete without error on all supported OSes
* Install the expected tools and configurations
* Fail loudly and clearly if something breaks

---

## 🧩 Test Types

### 1. **Smoke Tests**

* Located in `/tests/`
* Run after initial setup completes
* Validate presence of tools like `git`, `python`, `nvm`, `docker`, etc.
* Output pass/fail messages to console and `logs/`

### 2. **Dry-Run Mode**

* All setup scripts must support `--dry-run`
* Should log actions *without* making system changes
* Used in CI to test config logic and install planning

### 3. **Manual Validation Checklist**

* Validate dotfile links
* Validate language versions match config
* Confirm correct shell is set (`zsh` / `PowerShell`)
* Check CLI aliases and shell prompt load

---

## 🧪 GitHub Actions

CI is configured in `.github/workflows/ci.yml`. It runs on every push and PR to `main`.

### Steps:

1. Boot VM/matrix: macOS-latest, Ubuntu-latest, Windows-latest
2. Run `bootstrap` in each OS context
3. Capture logs
4. Run smoke tests
5. Fail the job if any tool is missing or error is found in logs

### Matrix:

| OS      | Test Strategy                  |
| ------- | ------------------------------ |
| macOS   | Full setup + smoke test        |
| Ubuntu  | Full setup + smoke test        |
| Windows | PowerShell install + WSL check |

---

## 🛑 Failure Conditions

The CI job will fail if:

* Any `setup.*` script exits non-zero
* Any required tool is missing after install
* Any `.log` file contains `[ERROR]` string
* Smoke test fails for expected version or path

---

## 🧪 Test Naming Conventions

* `smoke-*.sh` / `smoke-*.ps1` for OS-level validation
* `validate-dotfiles.sh` for symlink checks
* `test-setup.sh` for post-bootstrap assertions

---

## 🧼 Local Testing

Run smoke tests after a local install:

```sh
./scripts/test-setup.sh
./tests/smoke-tools.sh
```

Or test a script change in dry-run mode:

```sh
./scripts/setup.sh --dry-run
```

For Windows:

```powershell
.\scripts\setup.ps1 -DryRun
```

---

## 📂 Key Files

* `/scripts/test-setup.sh`
* `/tests/smoke-*.sh`, `smoke-*.ps1`
* `.github/workflows/ci.yml`
* `/logs/error.log`, `setup.log`

---

## 🚧 Future Additions

* Full Lint + ShellCheck/PSRule
* Test against pinned language versions
* CI badge in README
