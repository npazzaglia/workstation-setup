# 🛠 Module: CLI Aliases

## ✅ Purpose

Define and install a consistent set of cross-platform command-line aliases to accelerate workflow and improve ergonomics.

---

## 📦 Install Method

| Shell      | File Injected To        | Managed By            |
| ---------- | ----------------------- | --------------------- |
| zsh/bash   | `~/.zshrc`, `~/.bashrc` | `configs/aliases.sh`  |
| PowerShell | `$PROFILE`              | `configs/aliases.ps1` |

---

## 🔧 Configuration

Aliases are stored in:

* `configs/aliases.sh` (for bash/zsh)
* `configs/aliases.ps1` (for PowerShell)

**Typical entries include:**

```bash
alias g='git'
alias d='docker'
alias ll='ls -la'
alias v='nvim'
```

```powershell
Set-Alias g git
Set-Alias d docker
Function ll { Get-ChildItem -Force }
```

---

## 🌍 Environment Impact

* Adds custom commands usable in all terminals
* Shortens frequently-used CLI workflows
* Should be loaded early in shell startup

---

## 🧪 Smoke Test

```bash
echo $SHELL
type g
type ll
```

```powershell
Get-Command g
Get-Command ll
```

Expected: Aliases resolve to real commands.

---

## ❗ Notes & Edge Cases

* Must avoid aliasing built-in commands or conflicting with system tools
* PowerShell aliases require `Set-Alias` or functions for multi-arg commands
* Sourced manually for non-login shells (e.g., terminals launched from GUI apps)

---

## ⏭️ Related Modules

* `dotfiles`: Loads or sources alias files
* `zsh` / `powershell`: Target environments for injection
* `git`, `docker`, `nvim`: Common alias targets
