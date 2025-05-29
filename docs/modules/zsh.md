# 🛠 Module: zsh (Z Shell)

## ✅ Purpose

Install and configure `zsh` as the default login shell on macOS and Linux systems. Enhances shell UX with themes, completions, and plugins via `oh-my-zsh`.

---

## 📦 Install Method

| OS      | Method           | Source                       |
| ------- | ---------------- | ---------------------------- |
| macOS   | Pre-installed    | Optional: `brew install zsh` |
| Linux   | APT / Homebrew   | `apt install zsh` or `brew`  |
| Windows | ❌ Not applicable | PowerShell is used instead   |

---

## 🔧 Configuration

| File        | Target Path     | Managed By       |
| ----------- | --------------- | ---------------- |
| `.zshrc`    | `~/.zshrc`      | `configs/.zshrc` |
| `oh-my-zsh` | `~/.oh-my-zsh`  | Install script   |
| Theme       | `ZSH_THEME=...` | Set in `.zshrc`  |

**Behavior:**

* Backs up existing `.zshrc` if present
* Symlinks `configs/.zshrc` into `~`
* Installs `oh-my-zsh` from GitHub if not present

---

## 🌍 Environment Impact

* Sets `zsh` as the default shell (`chsh -s $(which zsh)`)
* Loads aliases, completions, and prompt themes on login
* Autoloads environment managers (e.g., `pyenv`, `nvm`) if present in config

---

## 🧪 Smoke Test

```bash
zsh --version
echo $SHELL
zsh -c 'echo Loaded ZSH config'
```

Expected: `zsh` is the current shell and `.zshrc` has executed.

---

## ❗ Notes & Edge Cases

* On Linux, user may need to install `fonts-powerline` for prompt themes
* If `zsh` is not the user’s login shell, it must be set manually (`chsh`)
* Some plugins require `git` and network access during install

---

## ⏭️ Related Modules

* `dotfiles`: Supplies `.zshrc`, aliases, theme config
* `pyenv`, `nvm`: Should be loaded in `.zshrc`
* `git`: Required for `oh-my-zsh` and plugin manager
