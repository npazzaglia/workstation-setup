# 🛠 Module: Dotfiles

## ✅ Purpose

Install and manage custom configuration files for shells, git, editors, and other CLI tools to standardize the development environment.

---

## 📦 Install Method

| OS  | Method          | Source      |
| --- | ---------------- | ----------- |
| All | `chezmoi apply` | `dotfiles/` |

---

## 🔧 Configuration

| Dotfile            | Target Path           | Source File                    | Notes                           |
| ------------------ | --------------------- | ------------------------------ | ------------------------------- |
| `.zshrc`           | `~/.zshrc`            | `dotfiles/dot_zshrc`               | Used by zsh login shell         |
| `.gitconfig`       | `~/.gitconfig`        | `dotfiles/dot_gitconfig`           | Git user identity, settings     |
| `settings.json`    | VS Code settings path | `dotfiles/dot_config/Code/User/settings.json` | Optional, if `vscode` installed |
| `aliases.sh`       | `~/aliases.sh`        | `dotfiles/aliases.sh`          | Common shell aliases            |
| `aliases.ps1`      | `$PROFILE`            | `dotfiles/aliases.ps1`         | PowerShell aliases              |

---

## 🌍 Environment Impact

* Updates shell startup behavior
* Loads aliases, language managers, themes
* Applies consistent tooling config across machines

---

## 🧪 Smoke Test

```bash
diff ~/.zshrc dotfiles/dot_zshrc
diff ~/.gitconfig dotfiles/dot_gitconfig
```

```powershell
Compare-Object (Get-Content $PROFILE) (Get-Content dotfiles/aliases.ps1)
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
