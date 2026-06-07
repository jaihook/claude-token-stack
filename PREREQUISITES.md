# Prerequisites

Before running the Claude Token Stack installer, you need a few tools installed. This page walks you through each one with beginner-friendly instructions.

---

## Claude Code

Claude Code is the AI assistant that this stack optimises. If you don't have it yet:

1. Go to [claude.ai/code](https://claude.ai/code)
2. Follow the install instructions for your platform
3. Verify it works: open Terminal and run `claude --version`

---

## Node.js ≥ 18

Node.js is a JavaScript runtime used by layers 3 and 4.

**Check if you have it:**

```bash
node --version
```

If it prints `v18.x.x` or higher, you're good. If it prints a lower version or "command not found", install or upgrade.

**Install Node.js:**

- Go to [nodejs.org](https://nodejs.org) and download the **LTS** version (the one marked "Recommended For Most Users").
- Run the installer and follow the prompts.
- Open a **new** terminal and run `node --version` to confirm.

> **Advanced users:** You can use [nvm](https://github.com/nvm-sh/nvm) to manage multiple Node versions:
> ```bash
> nvm install --lts
> nvm use --lts
> ```

npm (the Node package manager) is included with Node.js — you don't need to install it separately.

---

## Python + pip

Python is needed for Layer 2 (Headroom). This layer is optional — the other 4 layers work without it.

**Check if you have it:**

```bash
python3 --version
pip3 --version
```

If both print version numbers, you're set.

**Install Python:**

- Go to [python.org/downloads](https://www.python.org/downloads/)
- Download the latest stable release and run the installer
- On the install screen, **tick "Add Python to PATH"** (important!)
- Open a new terminal and run `python3 --version` to confirm

**Mac users:** Python 3 can also be installed via Homebrew:

```bash
brew install python
```

---

## curl

curl downloads files from the internet. It's used to fetch the installer itself.

**Mac and Linux:** curl comes pre-installed. Verify with:

```bash
curl --version
```

**Windows (WSL):** curl is included in Ubuntu/WSL. If missing:

```bash
sudo apt-get install curl
```

---

## Windows Users

This script is written for Mac and Linux. On Windows, use **WSL (Windows Subsystem for Linux)**:

1. Open PowerShell as Administrator and run:
   ```
   wsl --install
   ```
2. Restart your computer
3. Open the "Ubuntu" app from the Start menu
4. Follow the prerequisites above inside the Ubuntu terminal
5. Run the Claude Token Stack installer from there

Microsoft's full WSL guide: [learn.microsoft.com/en-us/windows/wsl/install](https://learn.microsoft.com/en-us/windows/wsl/install)

---

Once all prerequisites are in place, go back to [README.md](README.md#step-by-step-install-guide) to run the installer.
