# 🛠 Module: PowerShell

## ✅ Purpose

Configure PowerShell as the default shell environment on Windows (and optionally on macOS/Linux), including profile customization, alias injection, and module installation.

---

## 📦 Install Method

| OS      | Method              | Source                                                              |
| ------- | ------------------- | ------------------------------------------------------------------- |
| Windows | Built-in / Updated  | `winget install Microsoft.PowerShell` or `choco install powershell` |
| macOS   | Homebrew            | `brew install --cask powershell`                                    |
| Linux   | APT / Snap / Script | `apt install powershell` or snap                                    |

---

## 🔧 Configuration

| File                               | Target Path                    | Managed By            |
| ---------------------------------- | ------------------------------ | --------------------- |
| `Microsoft.PowerShell_profile.ps1` | `$PROFILE` (platform-specific) | `scripts/setup.ps1`   |
| Aliases & Prompt                   | Defined in profile script      | `configs/aliases.ps1` |

**Behavior:**

* Sets execution policy to `RemoteSigned` or `Bypass` for local scripts
* Loads custom profile that includes aliases, tools, and environment config
* Optional: adds autocompletions or `PSReadLine` enhancements

---

## 🌍 Environment Impact

* PowerShell available via `pwsh` or `powershell`
* Startup profile auto-runs aliases and ENV setup
* Supports running setup scripts (`bootstrap`, `setup.ps1`) reliably

---

## 🧪 Smoke Test

```powershell
$PROFILE
Test-Path $PROFILE
Get-Command pwsh
```

Expected: profile path exists, PowerShell launches correctly, aliases work.

---

## ❗ Notes & Edge Cases

* `$PROFILE` path varies:

  * Windows: `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`
  * macOS/Linux: `$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1`
* Some settings (like fonts or PSReadLine) require elevated privileges or manual confirmation
* Windows default PowerShell (5.x) may not support all modules—ensure PowerShell 7+ (`pwsh`) is available

---

## ⏭️ Related Modules

* `dotfiles`: May include reusable PowerShell snippets or config blocks
* `git`: CLI integrations (e.g. prompt with Git branch)
* `nvm`, `pyenv`: Should be initialized in `$PROFILE` if used in PowerShell
