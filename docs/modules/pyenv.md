# 🛠 Module: pyenv

## ✅ Purpose

Install and configure `pyenv` to manage Python versions across platforms. Supports Python version pinning, per-project isolation, and global defaults.

---

## 📦 Install Method

| OS      | Method               | Source                        |
| ------- | -------------------- | ----------------------------- |
| macOS   | Homebrew             | `brew install pyenv`          |
| Linux   | APT or Homebrew      | `apt install pyenv` or `brew` |
| Windows | Manual / `pyenv-win` | `choco install pyenv-win`     |

---

## 🔧 Configuration

| File              | Target Path                                          | Managed By               |
| ----------------- | ---------------------------------------------------- | ------------------------ |
| `.python-version` | Project root (if needed)                             | `configs/dev_env.yml`    |
| `pyenv init`      | Shell config (`.zshrc`, `.bashrc`, or `profile.ps1`) | `setup.sh` / `setup.ps1` |

**Behavior:**

* Adds shims to `$PATH`
* Enables pyenv in login shell via shell init hook
* Optional: installs `pyenv-virtualenv` if specified in config

---

## 🌍 Environment Impact

* Adds `~/.pyenv/bin` to `$PATH`
* Python version resolved via `.python-version` or global default
* Enables isolated Python per project

---

## 🧪 Smoke Test

```bash
pyenv --version
pyenv install --list | grep 3.10
pyenv versions
```

Expected: list of installable versions, ability to switch/interact with Python installations.

---

## ❗ Notes & Edge Cases

* On Windows, `pyenv-win` differs slightly—some plugins not supported
* macOS may require Xcode Command Line Tools for some builds
* Linux may need `build-essential` and `libssl-dev`

---

## ⏭️ Related Modules

* `nvm`: similar version manager for Node.js
* `zsh` or `powershell`: needed for initializing pyenv correctly
* `dotfiles`: may contain `.python-version` or aliases like `python3.10`
