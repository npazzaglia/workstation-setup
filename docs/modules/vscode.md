# 🛠 Module: Visual Studio Code (VS Code)

## ✅ Purpose

Install Visual Studio Code and apply user configuration (extensions, settings) across platforms.

---

## 📦 Install Method

| OS      | Method            | Source                                                            |
| ------- | ----------------- | ----------------------------------------------------------------- |
| macOS   | Homebrew Cask     | `brew install --cask visual-studio-code`                          |
| Linux   | Homebrew / direct | `brew install --cask visual-studio-code` or `.deb` from Microsoft |
| Windows | Chocolatey        | `choco install vscode`                                            |

---

## 🔧 Configuration

| File                  | Target Path                                                                                          | Managed By                     |
| --------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------ |
| `settings.json`       | `~/.config/Code/User/settings.json` (Linux/macOS) <br> `%APPDATA%\Code\User\settings.json` (Windows) | `dotfiles/dot_config/Code/User/settings.json` |
| Extensions List (opt) | `vscode-extensions.txt`                                                                              | `dotfiles/`                     |

**Merge Behavior:**

* If `settings.json` already exists, it is backed up before overwrite
* Extensions can be installed via:

  ```bash
  cat vscode-extensions.txt | xargs -L 1 code --install-extension
  ```

---

## 🌍 Environment Impact

* Adds `code` CLI to `$PATH` if not already installed
* Auto-launches editor on install (optional step)
* Enables Git + linter integrations if configured

---

## 🧪 Smoke Test

```bash
code --version
code --list-extensions
```

Expected: prints VS Code version and installed extension list.

---

## ❗ Notes & Edge Cases

* On macOS, ensure `code` is linked via Code > Command Palette > “Install ‘code’ in PATH”
* On Windows, restart may be required for `%PATH%` update
* Extension install can fail silently if `code` is not available in shell

---

## ⏭️ Related Modules

* `git`: VS Code uses Git integration
* `zsh` / `PowerShell`: Launch aliases or shell helpers for `code`
* `dotfiles`: May include `.vscode/` project config
