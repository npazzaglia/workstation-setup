# 🧪 /tests/README.md – Smoke & CI Test Suite

This directory contains all smoke tests, validation checks, and CI test utilities used to confirm that `workstation-setup` installs tools correctly across all supported platforms.

---

## 🧭 Purpose

Ensure that:

* The `bootstrap` script runs to completion with zero errors
* Core tools are installed and functional
* Environment settings (e.g. dotfiles, shell, aliases) are correctly applied
* Failures are caught early in GitHub Actions

---

## 📦 Test Categories

### 🔹 Smoke Tests

* OS-specific `smoke-*.sh` and `smoke-*.ps1` scripts
* Confirm required binaries exist in `$PATH`
* Check for expected version numbers or config files

### 🔹 Setup Validator

* `scripts/test-setup.sh` runs post-install assertions
* Tests for shell config, dotfile symlinks, editor presence
* Logs status to `logs/` and prints success/failure summary

---

## 🧪 Running Tests Locally

### Unix/macOS

```sh
./scripts/setup.sh
./scripts/test-setup.sh
./tests/smoke-tools.sh
```

### Windows

```powershell
./scripts/setup.ps1
./tests/smoke-tools.ps1
```

---

## ✅ Passing Criteria

* Script exits with code `0`
* Required tools pass version check (e.g. `git --version`, `python -V`)
* Dotfiles exist and are symlinked properly
* Shell loads without error and aliases are functional

---

## ❌ Failure Conditions

* Any test script exits non-zero
* Errors appear in `logs/error.log`
* Expected files or shell configs are missing
* GitHub Actions job fails for any OS target

---

## 🧪 GitHub Actions Integration

CI workflow defined in `.github/workflows/ci.yml`:

* Runs on `push` or `pull_request`
* Builds fresh OS VMs using matrix (macOS, Ubuntu, Windows)
* Executes `bootstrap` + test suite per OS
* Uploads `logs/setup.log` and `error.log` as artifacts

---

## 🧼 Test Maintenance Guidelines

* Keep test output readable and minimal
* Always test new install modules with a smoke test first
* Match test script names to the tool or config being validated
* Use `--dry-run` when testing logic changes that should not mutate state

---

## 📂 Files in This Directory

| File                   | Purpose                              |
| ---------------------- | ------------------------------------ |
| `smoke-tools.sh`       | Verifies core CLI tools on Unix      |
| `smoke-tools.ps1`      | Verifies CLI tools on Windows        |
| `validate-dotfiles.sh` | Checks for symlinks and shell config |
| `smoke-editor.sh`      | Confirms VS Code is available        |

---

## 🔁 Related Files

* `scripts/test-setup.sh`
* `logs/setup.log`, `logs/error.log`
* `.github/workflows/ci.yml`

---

## 📌 Future Enhancements

* Add shell startup test to confirm aliases prompt
* Include `ShellCheck` or `PSRule` lint validation
* Add matrix entry for WSL2 (Ubuntu on Windows)
