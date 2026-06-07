# Troubleshooting

This page covers the most common issues after running the Claude Token Stack installer.

---

## RTK

### `rtk: command not found` after install

The installer added RTK to your PATH, but the current terminal session doesn't know about it yet.

**Fix:** Close your terminal and open a new one, then try `rtk --version`.

### RTK hook wasn't registered

If you see `run 'rtk init -g' after reopening your terminal` in the installer output:

```bash
rtk init -g
```

Run this in a fresh terminal after the install completes.

---

## Headroom (Layer 2)

### "Skipping Headroom (no pip)"

Headroom requires Python and pip. The installer detected neither on your system.

**Fix:** Install Python first — see [PREREQUISITES.md](PREREQUISITES.md#python--pip). Then run:

```bash
pip install "headroom-ai[all]"
```

### Headroom install failed

If pip is present but the install still failed, try with the `--user` flag:

```bash
pip install --user "headroom-ai[all]"
```

Or upgrade pip first:

```bash
pip install --upgrade pip
pip install "headroom-ai[all]"
```

---

## context-mode (Layer 3)

### `context-mode` not listed in `/mcp`

Either the `claude` CLI wasn't found during install, or the registration step failed.

**Fix:** Run this command manually in your terminal:

```bash
claude mcp add context-mode -- npx -y context-mode
```

Then restart Claude Code and check `/mcp` again.

### `claude: command not found`

Claude Code CLI is not installed or not in your PATH.

**Fix:** Install Claude Code from [claude.ai/code](https://claude.ai/code), then re-run the installer or the manual command above.

---

## Codebase Memory MCP (Layer 4)

### `codebase-memory-mcp` not listed in `/mcp`

The npm package installed but the Claude Code registration step failed.

**Fix:**

```bash
codebase-memory-mcp install
```

Then restart Claude Code.

### npm install failed

Your Node.js version may be too old (requires ≥ 18).

**Fix:** Check your version:

```bash
node --version
```

If it's below 18, upgrade Node.js — see [PREREQUISITES.md](PREREQUISITES.md#nodejs--18).

---

## Caveman (Layer 5)

### Caveman install failed

**Fix:** Install it manually:

```bash
curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash
```

Then restart Claude Code and type `/caveman`.

---

## General

### The whole script failed immediately

Make sure `curl` and `bash` are available:

```bash
curl --version
bash --version
```

If either is missing, see [PREREQUISITES.md](PREREQUISITES.md).

### I want to re-run just one layer

Each layer is independent. Find the relevant section in `install-claude-token-stack.sh` and copy the commands — or use the manual commands listed above in this guide.

### Something else broke

[Open an issue](https://github.com/jaihook/claude-token-stack/issues) with:
- Your OS (Mac/Linux/WSL)
- Output from the installer (paste the full terminal output)
- Which layer failed
