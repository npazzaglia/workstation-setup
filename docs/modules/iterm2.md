# 🛠 Module: iTerm2 (macOS Terminal Emulator)

## ✅ Purpose

Install and optionally configure [iTerm2](https://iterm2.com/) on macOS as the default terminal application. Supports advanced features like profiles, hotkeys, and shell integration.

---

## 📦 Install Method

| OS    | Method        | Source                       |
| ----- | ------------- | ---------------------------- |
| macOS | Homebrew Cask | `brew install --cask iterm2` |

> ❌ Not supported on Linux or Windows.

---

## 🔧 Configuration (Optional)

| Item                 | Method                    | Notes                                   |
| -------------------- | ------------------------- | --------------------------------------- |
| Default profile      | Manual / `defaults write` | iTerm2 config stored in `~/Library`     |
| Font (e.g. MesloLGS) | Homebrew or direct        | Must match `.zshrc` / Powerline themes  |
| Preferences sync     | GUI or defaults           | Optional: auto-load from dotfiles repo  |
| Shell integration    | Scripted or GUI install   | Enables Cmd+Click URLs, better shell UX |

> ⚠️ Configuration is mostly GUI-driven; scripts may trigger only partial setup.

---

## 🌍 Environment Impact

* Installs `/Applications/iTerm.app`
* Launchable via Spotlight or `open -a iTerm`
* Recommended for use with `zsh` + `oh-my-zsh` profiles

---

## 🧪 Smoke Test

```bash
open -a iTerm
```

Expected: iTerm launches with default shell (e.g., zsh).

---

## ❗ Notes & Edge Cases

* Fonts like MesloLGS must be installed manually or via Homebrew Cask
* Preferences may not auto-load unless synced with `defaults` or GUI path
* Initial shell integration prompt may appear unless suppressed via config

---

## ⏭️ Related Modules

* `zsh`: Often used with iTerm2 for prompt and theme rendering
* `dotfiles`: May include iTerm2 preference folder
* `fonts`: Required for theme icons or Powerline support
