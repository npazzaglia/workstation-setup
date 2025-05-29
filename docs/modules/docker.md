# 🛠 Module: Docker

## ✅ Purpose

Install Docker Engine and CLI for container-based development across all supported platforms.

---

## 📦 Install Method

| OS      | Method            | Source                         |
| ------- | ----------------- | ------------------------------ |
| macOS   | Homebrew Cask     | `brew install --cask docker`   |
| Linux   | Official APT repo | `apt install docker-ce`        |
| Windows | Chocolatey        | `choco install docker-desktop` |

---

## 🔧 Configuration

| Config Item                    | Description                 | Notes                        |
| ------------------------------ | --------------------------- | ---------------------------- |
| Docker Group (Linux)           | Adds user to `docker` group | Prevents `sudo` on every run |
| Docker Desktop (macOS/Windows) | GUI app + daemon            | May require manual launch    |
| Daemon Config (opt)            | `/etc/docker/daemon.json`   | For registry mirrors, etc.   |

---

## 🌍 Environment Impact

* Adds `docker` and `docker-compose` to `$PATH`
* On Linux, avoids needing `sudo docker` after group is set
* Background daemon starts on login (macOS/Windows)

---

## 🧪 Smoke Test

```bash
docker --version
docker info | grep 'Server Version'
docker run hello-world
```

Expected: container starts and exits with success message.

---

## ❗ Notes & Edge Cases

* Docker Desktop on macOS/Windows may prompt for login or license acceptance
* WSL2 backend required for Windows (auto-installed by Docker Desktop)
* On Linux, restart required after adding user to docker group:

  ```bash
  sudo usermod -aG docker $USER && newgrp docker
  ```

---

## ⏭️ Related Modules

* `kubectl`, `helm`: Often co-installed for container orchestration
* `dotfiles`: May include bash/zsh aliases like `dk` for `docker`
* `packages/`: Includes install source declaration per OS
