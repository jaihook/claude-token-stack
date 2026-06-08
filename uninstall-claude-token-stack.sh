#!/usr/bin/env bash
# ============================================================
#  Claude Code Token Stack — One-Command Uninstaller
#  Removes: RTK · Headroom · context-mode · codebase-memory-mcp · Caveman
#  Usage: curl -fsSL https://raw.githubusercontent.com/jaihook/claude-token-stack/main/uninstall-claude-token-stack.sh | bash
# ============================================================

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

log()  { echo -e "${CYAN}[stack]${RESET} $*"; }
ok()   { echo -e "${GREEN}[  ok ]${RESET} $*"; }
warn() { echo -e "${YELLOW}[ warn]${RESET} $*"; }

echo -e "\n${BOLD}╔══════════════════════════════════════════════════════╗"
echo -e "║   Claude Code Token Stack Uninstaller               ║"
echo -e "║   RTK · Headroom · context-mode · CBM · Caveman     ║"
echo -e "╚══════════════════════════════════════════════════════╝${RESET}\n"

# ── Layer 1 — RTK ────────────────────────────────────────────
echo -e "\n${BOLD}[Layer 1/5] RTK${RESET}"

# Remove rtk binary
for RTK_PATH in "$HOME/.local/bin/rtk" "/usr/local/bin/rtk" "$HOME/.cargo/bin/rtk"; do
  if [[ -f "$RTK_PATH" ]]; then
    rm -f "$RTK_PATH" && ok "Removed $RTK_PATH."
  fi
done

# Remove rtk shell init lines added by rtk init -g
for SHELL_RC in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile"; do
  if [[ -f "$SHELL_RC" ]] && grep -q "rtk" "$SHELL_RC" 2>/dev/null; then
    sed -i.bak '/rtk/d' "$SHELL_RC" && ok "Removed RTK lines from $SHELL_RC."
  fi
done

if ! command -v rtk &>/dev/null; then
  ok "RTK removed."
else
  warn "rtk still in PATH — restart terminal to confirm removal."
fi

# ── Layer 2 — Headroom ───────────────────────────────────────
echo -e "\n${BOLD}[Layer 2/5] Headroom${RESET}"

PIP_CMD=$(command -v pip3 2>/dev/null || command -v pip 2>/dev/null || true)
if [[ -n "$PIP_CMD" ]]; then
  if $PIP_CMD show headroom-ai &>/dev/null 2>&1; then
    log "Uninstalling headroom-ai..."
    $PIP_CMD uninstall headroom-ai -y --quiet && ok "Headroom removed."
  else
    ok "Headroom not installed — skipping."
  fi
else
  warn "pip not found — Headroom likely not installed."
fi

# ── Layer 3 — context-mode ───────────────────────────────────
echo -e "\n${BOLD}[Layer 3/5] context-mode${RESET}"

if command -v claude &>/dev/null; then
  log "Removing context-mode MCP from Claude Code..."
  claude mcp remove context-mode 2>/dev/null \
    && ok "context-mode MCP removed." \
    || warn "context-mode not registered (already removed or never added)."
else
  warn "claude CLI not found — remove manually: claude mcp remove context-mode"
fi

# ── Layer 4 — Codebase Memory MCP ───────────────────────────
echo -e "\n${BOLD}[Layer 4/5] Codebase Memory MCP${RESET}"

if command -v claude &>/dev/null; then
  log "Removing codebase-memory-mcp from Claude Code..."
  claude mcp remove codebase-memory-mcp 2>/dev/null \
    && ok "codebase-memory-mcp MCP removed." \
    || warn "codebase-memory-mcp not registered (already removed or never added)."
fi

if npm list -g codebase-memory-mcp &>/dev/null 2>&1; then
  log "Uninstalling codebase-memory-mcp npm package..."
  npm uninstall -g codebase-memory-mcp --silent && ok "codebase-memory-mcp npm package removed."
else
  ok "codebase-memory-mcp npm package not installed — skipping."
fi

# ── Layer 5 — Caveman ────────────────────────────────────────
echo -e "\n${BOLD}[Layer 5/5] Caveman${RESET}"

CAVEMAN_SKILL="$HOME/.claude/skills/caveman.md"
CAVEMAN_DIR="$HOME/.claude/skills/caveman"

if [[ -f "$CAVEMAN_SKILL" ]]; then
  rm -f "$CAVEMAN_SKILL" && ok "Removed $CAVEMAN_SKILL."
elif [[ -d "$CAVEMAN_DIR" ]]; then
  rm -rf "$CAVEMAN_DIR" && ok "Removed $CAVEMAN_DIR."
else
  ok "Caveman skill not found — already removed or never installed."
fi

# ── Done ─────────────────────────────────────────────────────
echo -e "\n${BOLD}${GREEN}╔══════════════════════════════════════════════════════╗"
echo -e "║   Uninstall complete!                                ║"
echo -e "╚══════════════════════════════════════════════════════╝${RESET}"

echo -e "
${BOLD}Next steps:${RESET}
  1. ${CYAN}Restart your terminal${RESET} so PATH changes take effect.
  2. ${CYAN}Restart Claude Code${RESET} to deregister MCP servers.
  3. Inside Claude Code, run ${CYAN}/mcp${RESET} to confirm context-mode and CBM are gone.

${BOLD}Manual checks:${RESET}
  - If RTK lines persist in shell config, edit ~/.bashrc or ~/.zshrc and remove them.
  - If Claude Code settings.json still references RTK hook, remove that block manually.
"
