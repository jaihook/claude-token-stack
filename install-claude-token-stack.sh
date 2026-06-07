#!/usr/bin/env bash
# ============================================================
#  Claude Code Token Stack — One-Command Installer
#  Layers: RTK · Headroom · context-mode · codebase-memory-mcp · Caveman
#  Usage: curl -fsSL https://your-host/install-claude-token-stack.sh | bash
# ============================================================

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

log()  { echo -e "${CYAN}[stack]${RESET} $*"; }
ok()   { echo -e "${GREEN}[  ok ]${RESET} $*"; }
warn() { echo -e "${YELLOW}[ warn]${RESET} $*"; }
fail() { echo -e "${RED}[fail ]${RESET} $*"; }

echo -e "\n${BOLD}╔══════════════════════════════════════════════════════╗"
echo -e "║   Claude Code Token Stack Installer                 ║"
echo -e "║   RTK · Headroom · context-mode · CBM · Caveman     ║"
echo -e "╚══════════════════════════════════════════════════════╝${RESET}\n"

# ── Prerequisites ───────────────────────────────────────────
log "Checking prerequisites..."

require() {
  if ! command -v "$1" &>/dev/null; then
    fail "Required: $1 — please install it and re-run."
    exit 1
  fi
}

require curl
require node
require npm

NODE_MAJOR=$(node -e "process.stdout.write(process.versions.node.split('.')[0])")
if (( NODE_MAJOR < 18 )); then
  fail "Node ≥18 required (you have $(node --version)). Please upgrade."
  exit 1
fi

# pip is optional — warn but continue
if ! command -v pip3 &>/dev/null && ! command -v pip &>/dev/null; then
  warn "pip not found — Headroom (Layer 2) will be skipped."
  SKIP_HEADROOM=1
else
  SKIP_HEADROOM=0
fi

ok "Prerequisites satisfied."

# ── Layer 1 — RTK (CLI output compression, 60-90%) ──────────
echo -e "\n${BOLD}[Layer 1/5] RTK — CLI output proxy${RESET}"
log "Installing RTK..."

if curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh; then
  ok "RTK installed."
  log "Registering RTK hook for Claude Code..."
  if command -v rtk &>/dev/null; then
    rtk init -g 2>/dev/null && ok "RTK hook registered globally." \
      || warn "rtk init -g failed — run it manually after restart."
  else
    warn "rtk not in PATH yet; run 'rtk init -g' after reopening your terminal."
  fi
else
  warn "RTK install failed — skipping. Install manually: https://github.com/rtk-ai/rtk"
fi

# ── Layer 2 — Headroom (API payload compression, 47-92%) ────
echo -e "\n${BOLD}[Layer 2/5] Headroom — API proxy${RESET}"

if [[ "$SKIP_HEADROOM" -eq 1 ]]; then
  warn "Skipping Headroom (no pip). Install Python then run: pip install 'headroom-ai[all]'"
else
  PIP_CMD=$(command -v pip3 || command -v pip)
  log "Installing headroom-ai..."
  if $PIP_CMD install "headroom-ai[all]" --quiet; then
    ok "Headroom installed."
    log "To launch: headroom wrap claude  (starts proxy + Claude Code)"
    log "To start proxy only: headroom proxy --port 8787"
  else
    warn "Headroom install failed. Try manually: pip install 'headroom-ai[all]'"
  fi
fi

# ── Layer 3 — context-mode (MCP output sandboxing, ~98%) ────
echo -e "\n${BOLD}[Layer 3/5] context-mode — MCP output sandbox${RESET}"
log "Adding context-mode MCP server..."

if command -v claude &>/dev/null; then
  claude mcp add context-mode -- npx -y context-mode 2>/dev/null \
    && ok "context-mode MCP registered." \
    || warn "context-mode MCP add failed — try: claude mcp add context-mode -- npx -y context-mode"
else
  warn "claude CLI not found. Register manually after installing Claude Code:"
  warn "  claude mcp add context-mode -- npx -y context-mode"
fi

# ── Layer 4 — Codebase Memory MCP (code graph, ~99%) ────────
echo -e "\n${BOLD}[Layer 4/5] Codebase Memory MCP — code knowledge graph${RESET}"
log "Installing codebase-memory-mcp..."

if npm install -g codebase-memory-mcp --silent 2>/dev/null; then
  ok "codebase-memory-mcp installed globally."
  if command -v claude &>/dev/null; then
    log "Registering CBM with Claude Code..."
    codebase-memory-mcp install 2>/dev/null \
      && ok "CBM registered." \
      || warn "CBM install hook failed — run 'codebase-memory-mcp install' manually."
  else
    warn "claude CLI not found. Run 'codebase-memory-mcp install' after installing Claude Code."
  fi
else
  warn "codebase-memory-mcp npm install failed. Try: npm install -g codebase-memory-mcp"
fi

# ── Layer 5 — Caveman (output verbosity, ~65-75%) ───────────
echo -e "\n${BOLD}[Layer 5/5] Caveman — compact Claude output${RESET}"
log "Installing Caveman skill..."

if curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash; then
  ok "Caveman installed."
  log "Activate per session with /caveman inside Claude Code."
  log "Auto-activate: caveman is configured in ~/.claude/skills/ and loads on startup."
else
  warn "Caveman install failed. Try manually: https://github.com/JuliusBrussee/caveman"
fi

# ── Done ─────────────────────────────────────────────────────
echo -e "\n${BOLD}${GREEN}╔══════════════════════════════════════════════════════╗"
echo -e "║   Installation complete!                             ║"
echo -e "╚══════════════════════════════════════════════════════╝${RESET}"

echo -e "
${BOLD}Next steps:${RESET}
  1. ${CYAN}Restart your terminal${RESET} so PATH changes take effect.
  2. ${CYAN}Restart Claude Code${RESET} to pick up hooks and MCP servers.
  3. Inside Claude Code, run ${CYAN}/mcp${RESET} to verify context-mode and CBM are listed.
  4. Type ${CYAN}/caveman${RESET} to activate compact output mode.
  5. For Headroom proxy mode, launch Claude Code via:
       ${CYAN}headroom wrap claude${RESET}

${BOLD}Expected savings:${RESET}
  RTK            CLI output         60–90 %
  Headroom       API payload        47–92 %
  context-mode   MCP output         ~98  %
  CBM            Code reads         ~99  %
  Caveman        Claude responses   65–75 %
  ─────────────────────────────────────────
  Combined                          85–95 %+
"
