# 🛠️ Troubleshooting Guide

This guide documents known issues, root causes, and proven solutions when running the `workstation-setup` scripts across macOS, Linux, and Windows.

---

## 📁 Logs and Debugging

* **Verbose Mode**

  * macOS/Linux: `./scripts/setup.sh -v`
  * Windows: `./scripts/setup.ps1 -Verbose`

* **Log Files**

  * `logs/setup.log`: Standard install output
  * `logs/error.log`: Captures command errors and failed steps

* **Validation Script**

  * Run `scripts/test-setup.sh` after install to confirm key tools are available

---

## 🟦 macOS/Linux Issues

### 🔴 `zsh: command not found: brew`

* **Cause:** Homebrew not installed or not in `$PATH`
* **Fix:**

  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

  Then restart the shell

### 🔴 `Permission denied` when running `setup.sh`

* **Cause:** Script not marked as executable
* **Fix:**

  ```sh
  chmod +x scripts/setup.sh
  ```

### 🔴 `ln: failed to create symbolic link: File exists`

* **Cause:** Target dotfile already exists
* **Fix:** Rename or remove old file before re-running setup:

  ```sh
  mv ~/.zshrc ~/.zshrc.backup
  ```

### 🔴 `pyenv: command not found`

* **Cause:** pyenv not installed or shell not reloaded
* **Fix:** Ensure install block ran and `eval "$(pyenv init -)"` is in `.zshrc`

### 🔴 VS Code not found after install

* **Cause:** VS Code CLI (`code`) not linked into PATH
* **Fix:** Install via VS Code command palette → “Install ‘code’ command in PATH”

---

## 🟥 Windows Issues

### 🔴 `setup.ps1 cannot be loaded because execution of scripts is disabled`

* **Cause:** Restricted PowerShell policy
* **Fix:**

  ```powershell
  Set-ExecutionPolicy Unrestricted -Scope Process -Force
  ```

### 🔴 Chocolatey not recognized

* **Cause:** PATH not refreshed after install
* **Fix:** Restart PowerShell, or manually add:

  ```powershell
  $env:Path += ";C:\ProgramData\chocolatey\bin"
  ```

### 🔴 Chocolatey install fails silently

* **Fix:** Ensure you're running as Administrator, then retry:

  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force;
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  ```

### 🔴 WSL not found

* **Cause:** Not installed
* **Fix:**

  ```powershell
  wsl --install
  ```

  Then restart your machine

### 🔴 Git not recognized

* **Cause:** Git install did not complete or PATH not updated
* **Fix:** Ensure Chocolatey installed Git and restart shell

---

## ✅ General Tips

* Always run scripts with appropriate permissions
* Validate internet connectivity before install
* Avoid manual installs in the middle of script execution

---

## 🧪 Still Stuck?

1. Check `logs/error.log`
2. Note your OS and shell version
3. Open a GitHub issue with:

   * Error output
   * Reproduction steps
   * Script version/commit hash

---

## 🧩 Related Files

* `scripts/setup.sh`, `setup.ps1`
* `logs/setup.log`, `error.log`
* `tests/smoke-*.sh`, `smoke-*.ps1`
