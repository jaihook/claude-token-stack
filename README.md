# Claude Token Stack

**Cut your Claude Code token bill by 85–95% in one command.**

Claude Code is powerful — but it can burn through tokens fast. This installer stacks 5 proven tools on top of each other to compress what gets sent to and from Claude, so you get the same results while spending far less.

No coding required. One command. Done in under 2 minutes.

---

## Quick Install

Open your **Terminal** (Mac/Linux) and paste this:

```bash
curl -fsSL https://raw.githubusercontent.com/jaihook/claude-token-stack/main/install-claude-token-stack.sh | bash
```
That's it. The script installs and wires up all 5 layers automatically.

---

## What Does It Do?

Think of tokens like the words Claude reads and writes. Every word costs money. This stack compresses those words — like a zip file for your AI conversations.

| Layer | Tool | What it compresses | Savings |
|-------|------|--------------------|---------|
| 1 | **RTK** | Terminal output sent to Claude | 60–90% |
| 2 | **Headroom** | API payloads over the network | 47–92% |
| 3 | **context-mode** | Output from MCP tools/plugins | ~98% |
| 4 | **Codebase Memory MCP** | Code files Claude reads | ~99% |
| 5 | **Caveman** | Claude's own verbose responses | 65–75% |
| | **Combined** | | **85–95%+** |

---

## Before You Start

You need a few things installed first. If you're not sure whether you have them, see [PREREQUISITES.md](PREREQUISITES.md) for step-by-step guides.

| Requirement | Why | Check if installed |
|-------------|-----|--------------------|
| **Claude Code** | The AI assistant this stack optimises | `claude --version` |
| **Node.js ≥ 18** | Needed for layers 3 and 4 | `node --version` |
| **npm** | Comes with Node.js | `npm --version` |
| **curl** | Downloads the installer | `curl --version` |
| **Python + pip** *(optional)* | Needed for Layer 2 (Headroom) | `python3 --version` |

If any command above prints a version number, you have it. If it says "command not found", see [PREREQUISITES.md](PREREQUISITES.md).

---

## Step-by-Step Install Guide

### Step 1 — Open Terminal

- **Mac**: Press `Cmd + Space`, type `Terminal`, press Enter.
- **Linux**: Press `Ctrl + Alt + T`.
- **Windows**: Use WSL — see [PREREQUISITES.md](PREREQUISITES.md#windows-users).

### Step 2 — Paste the install command

```bash
curl -fsSL https://raw.githubusercontent.com/jaihook/claude-token-stack/main/install-claude-token-stack.sh | bash
```

You'll see coloured output as each layer installs. Green `[ ok ]` means success. Yellow `[ warn]` means that layer was skipped (usually because a prerequisite is missing — that's okay, the rest still install).

### Step 3 — Restart your terminal

Close the terminal window and open a fresh one. This lets PATH changes take effect.

### Step 4 — Restart Claude Code

Close and reopen Claude Code.

### Step 5 — Verify the MCP tools loaded

Inside Claude Code, type:

```
/mcp
```

You should see `context-mode` and `codebase-memory-mcp` listed.

### Step 6 — Activate Caveman mode

Inside Claude Code, type:

```
/caveman
```

This switches Claude to ultra-compact output, cutting its response tokens by 65–75%.

### Step 7 — (Optional) Use Headroom proxy

If Python was installed, launch Claude Code through the Headroom proxy for maximum savings:

```bash
headroom wrap claude
```

Instead of just `claude`.

---

## After Install — Quick Checklist

- [ ] Terminal restarted
- [ ] Claude Code restarted
- [ ] `/mcp` shows `context-mode` and `codebase-memory-mcp`
- [ ] `/caveman` activated for compact output
- [ ] (Optional) Using `headroom wrap claude` to start Claude

---

## Troubleshooting

Something didn't work? See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for solutions to the most common issues.

**Quick fixes:**

| Problem | Fix |
|---------|-----|
| `rtk: command not found` | Restart your terminal |
| Headroom was skipped | Install Python — see [PREREQUISITES.md](PREREQUISITES.md) |
| `context-mode` not in `/mcp` | Run `claude mcp add context-mode -- npx -y context-mode` |
| `codebase-memory-mcp` not in `/mcp` | Run `codebase-memory-mcp install` |
| `node` version too old | Upgrade Node.js — see [PREREQUISITES.md](PREREQUISITES.md) |

---

## FAQ

**Do I need to know how to code?**
No. You just need to paste one command into Terminal. Everything else is automatic.

**Will this break Claude Code?**
No. Each layer is additive — if one fails to install, the others still work. You can uninstall any layer independently.

**Does this work on Windows?**
This script is written for Mac and Linux. Windows users can use [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/install) to run it.

**Do I need to run this every time I use Claude?**
No. Layers 1, 3, and 4 are installed once and run automatically. Layer 2 (Headroom) requires you to use `headroom wrap claude` to start Claude. Layer 5 (Caveman) requires typing `/caveman` once per session, or you can configure it to auto-activate.

**What if I only want some of the layers?**
The script is open source — you can read it and run any individual install command. Each layer section is clearly labeled.

**Is this safe?**
Yes. The script only installs open-source tools from their official repositories. It doesn't touch your API keys or Claude account.

---

## Contributing

Found a bug or want to improve the script? [Open an issue](https://github.com/jaihook/claude-token-stack/issues) or submit a pull request. All contributions welcome.

---

## License

MIT — use it, fork it, share it freely.
