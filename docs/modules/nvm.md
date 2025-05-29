# 🛠 Module: nvm (Node Version Manager)

## ✅ Purpose

Install and configure `nvm` to manage Node.js versions across platforms. Enables version pinning, isolated project environments, and global defaults.

---

## 📦 Install Method

| OS      | Method                     | Source                                                                                                                                        |        |
| ------- | -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| macOS   | Curl script                | \`curl -o- [https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh](https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh) | bash\` |
| Linux   | Curl script                | Same as macOS                                                                                                                                 |        |
| Windows | Manual (via `nvm-windows`) | Direct EXE installer from GitHub (or `choco install nvm`)                                                                                     |        |

---

## 🔧 Configuration

| File            | Target Path                        | Managed By               |
| --------------- | ---------------------------------- | ------------------------ |
| `.nvmrc`        | Project root (optional)            | `configs/dev_env.yml`    |
| `nvm init` hook | `.zshrc` / `.bashrc` / profile.ps1 | `setup.sh` / `setup.ps1` |

**Behavior:**

* Installs default Node version specified in config
* Updates `PATH` to include selected Node version
* Supports auto-switching via `.nvmrc` if enabled

---

## 🌍 Environment Impact

* Adds `nvm`, `node`, and `npm` to shell `$PATH`
* Enables project-based version isolation
* Prevents system-wide pollution of Node versions

---

## 🧪 Smoke Test

```bash
nvm --version
nvm install 20
nvm use 20
node --version
```

Expected: Node 20 installed and active, CLI commands resolve successfully.

---

## ❗ Notes & Edge Cases

* On Windows, `nvm-windows` is not 100% compatible with Unix `nvm` plugins
* `nvm` must be initialized manually in shell session if not added to profile
* On fresh Linux/macOS installs, restart shell after installation

**References:**

* [nvm-sh/nvm](https://github.com/nvm-sh/nvm)
* [coreybutler/nvm-windows](https://github.com/coreybutler/nvm-windows)

---

## ⏭️ Related Modules

* `pyenv`: Similar version manager for Python
* `dotfiles`: May define `.nvmrc`, aliases for `node`, `npm`
* `zsh` or `powershell`: Needed for initialization and version switching
