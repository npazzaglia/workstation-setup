# 🛠 Module: Git

## ✅ Purpose

Install and configure Git for version control on all supported platforms.

---

## 📦 Install Method

| OS      | Method          | Source                      |
| ------- | --------------- | --------------------------- |
| macOS   | Homebrew        | `brew install git`          |
| Linux   | APT or Homebrew | `apt install git` or `brew` |
| Windows | Chocolatey      | `choco install git`         |

---

## 🔧 Configuration

| File         | Target Path    | Managed By           |
| ------------ | -------------- | -------------------- |
| `.gitconfig` | `~/.gitconfig` | `configs/.gitconfig` |

**Merged via**: Upsert logic that preserves user-defined values but injects defaults if not present.

---

## 🌍 Environment Impact

* Adds `git` to `$PATH`
* May configure global username/email if not already set
* Enables GPG signing (future config enhancement)

---

## 🧪 Smoke Test

```bash
git --version
git config --list
```

Expected output includes version string and global config entries.

---

## ❗ Notes & Edge Cases

* On Windows, ensure `git` is added to the system PATH (Chocolatey usually handles this)
* On Linux, confirm correct `core.autocrlf` setting for cross-platform usage
* Git GUI not included (this project is CLI-focused)

---

## ⏭️ Related Modules

* `zsh` or `PowerShell`: to manage aliases for Git
* `VS Code`: Git integration via built-in SCM panel
* `dotfiles`: May include `.gitignore_global`
