# 🛠 Module: Dotfiles

## ✅ Purpose

Install and manage custom configuration files for shells, git, editors, and other CLI tools to standardize the development environment.

---

## 📦 Install Method

| OS  | Method          | Source               |
| --- | --------------- | -------------------- |
| All | Symlink or copy | `configs/` directory |

---

## 🔧 Configuration

| Dotfile            | Target Path           | Source File                    | Notes                           |
| ------------------ | --------------------- | ------------------------------ | ------------------------------- |
| `.zshrc`           | `~/.zshrc`            | `configs/.zshrc`               | Used by zsh login shell         |
| `.bashrc`          | `~/.bashrc`           | `configs/.bashrc`              | For bash (optional)             |
| `.gitconfig`       | `~/.gitconfig`        | `configs/.gitconfig`           | Git user identity, settings     |
| `settings.json`    | VS Code settings path | `configs/vscode-settings.json` | Optional, if `vscode` installed |
| `.nvmrc`           | Project root (opt)    | `configs/.nvmrc`               | Node.js version pinning         |
| `.python-version`  | Project root          | `configs/.python-version`      | Python version pinning (pyenv)  |
| PowerShell Profile | `$PROFILE`            | `configs/aliases.ps1`          | Auto-injected aliases           |

---

## 🌍 Environment Impact

* Updates shell startup behavior
* Loads aliases, language managers, themes
* Applies consistent tooling config across machines

---

## 🧪 Smoke Test

```bash
diff ~/.zshrc configs/.zshrc
diff ~/.gitconfig configs/.gitconfig
```

```powershell
Compare-Object (Get-Content $PROFILE) (Get-Content configs/aliases.ps1)
```

Expected: Files match or show successful linking/copying.

---

## ❗ Notes & Edge Cases

* Existing dotfiles should be backed up (e.g., `.zshrc.backup`)
* Symlinks preferred on Unix; fallback to copy on Windows
* Avoid overwriting files from other dotfile managers (e.g., chezmoi, stow) without warning
* Optional future support: auto-detect shells and only apply what’s relevant

---

## ⏭️ Related Modules

* `aliases`: Separate alias file sourced in dotfiles
* `vscode`, `zsh`, `powershell`: Consume dotfile configs
* `setup.sh`, `setup.ps1`: Detect and install dotfiles at bootstrap
