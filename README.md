# README

![License](https://img.shields.io/github/license/youruser/workstation-setup)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-blue)

---

## 🚀 Quick Start

Clone the repo and run the **cross-platform bootstrap script**:

### All Platforms

```sh
git clone https://github.com/youruser/workstation-setup.git
cd workstation-setup
```

* On macOS/Linux:

```bash
chmod +x bootstrap
./bootstrap
```

* On Windows PowerShell:

```powershell
Set-ExecutionPolicy Bypass -Scope Process
./bootstrap
```

### What It Does

* Detects OS automatically
* Invokes `scripts/setup.sh` on macOS/Linux
* Invokes `scripts/setup.ps1` via PowerShell on Windows

### ⚠️ Requirements

* `bash` must be available on macOS/Linux
* `pwsh` or `powershell` must be in PATH on Windows

---

## 📌 Project Overview

**Purpose:** Automate workstation configuration across platforms for consistency, speed, and reliability.

**Scope:**

* Supports macOS, Linux (Ubuntu/Debian), and Windows
* Installs core dev tools, packages, shells, IDEs
* Applies environment-specific dotfiles and system tweaks

**Repository Structure:**

```
📂 workstation-setup/
├── 📄 README.md
├── 📂 scripts/
│   ├── setup.sh              # macOS/Linux installer
│   ├── setup.ps1             # Windows installer
│   ├── test-setup.sh         # Validation script
├── 📂 configs/
│   └── dev-env.yml           # Tool declarations
├── 📂 dotfiles/
│   ├── dot_zshrc             # zsh config (chezmoi)
│   ├── dot_gitconfig         # Git config (chezmoi)
│   ├── aliases.sh            # Shared shell aliases
│   ├── aliases.ps1           # PowerShell aliases
│   └── dot_config/Code/User/settings.json # VS Code settings
├── 📂 packages/
│   ├── Brewfile              # macOS/Linux packages
│   ├── choco-install.ps1     # Windows packages
│   ├── requirements.txt      # Python deps
│   ├── package.json          # Node.js deps
├── 📂 logs/
│   ├── setup.log
│   ├── error.log
```

---

## 🧪 Installation & Usage Guide

### Prerequisites

* Internet access
* Admin/root privileges
* SSH key for GitHub (optional)

### Install Steps

See "Quick Start" above for exact steps.

---

## 🛠️ Troubleshooting

* Run with `-v` or `--verbose` for debug output
* Review `logs/error.log` for failed steps
* Use `scripts/test-setup.sh` for post-install verification

---

## 📦 Software & Configurations

### Core Tools

* **Git** (version control)
* **Homebrew / Chocolatey** (package management)
* **Languages:**

  * Python (via `pyenv`)
  * Node.js (via `nvm`)
* **Editors:**

  * VS Code
* **Containers:**

  * Docker

### Shell & CLI Customization

* macOS/Linux: `zsh` with `oh-my-zsh`
* Windows: PowerShell profile setup
* Shared: Aliases, prompt config, and editor settings

---

## 🔀 Cross-Platform Strategy

### macOS/Linux

* Homebrew-based setup
* Installs CLI tools, runtimes, editor, and shell config
* Applies symlinked dotfiles (.zshrc, .gitconfig, etc.)

### Windows

* Chocolatey + optional WSL
* PowerShell profile configuration
* Installs Git, VS Code, WSL2

---

## 🤖 Automation & CI Strategy

* **Idempotent**: Scripts safe to rerun with no side effects
* **Verbose logs**: All output written to `logs/setup.log`
* **CI tests**: GitHub Actions runs smoke tests on push/PR

---

## 🤝 Contributing

Pull requests are welcome! For major changes, open an issue first to propose your idea.

Please review [`CONTRIBUTING.md`](CONTRIBUTING.md) and [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) before contributing.

---

## 📄 License

MIT License. See [`LICENSE`](LICENSE) for full details.

---

## ⏭️ Next Steps

1. Finalize tool inventory and environment spec
2. Build setup scripts for all platforms
3. Define symlink + fallback strategy for dotfiles
4. Implement CI smoke test pipelines
5. Expand documentation and error recovery
