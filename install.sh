#!/usr/bin/env bash
set -e

# Detect shell config file
if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ]; then
  SHELL_RC="$HOME/.bash_profile"
else
  SHELL_RC="$HOME/.profile"
fi

echo "→ Installing Claude Code aliases into $SHELL_RC..."

ALIASES=$(cat <<'EOF'

# Claude Code aliases
alias ccs='claude --dangerously-skip-permissions --model sonnet'
alias cco='claude --dangerously-skip-permissions --model claude-opus-4-6'
alias cch='claude --dangerously-skip-permissions --model haiku'
EOF
)

# Check for duplicates
if grep -q "alias ccs=" "$SHELL_RC" 2>/dev/null; then
  echo "⚠️  Aliases already present in $SHELL_RC — skipping."
  exit 0
fi

echo "$ALIASES" >> "$SHELL_RC"
echo "✓ Aliases added to $SHELL_RC"

# Source
# shellcheck disable=SC1090
source "$SHELL_RC" 2>/dev/null || true
echo "✓ $SHELL_RC sourced"

echo ""
echo "✅ Done! cco / ccs / cch are ready."
