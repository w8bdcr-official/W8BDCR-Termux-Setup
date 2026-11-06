#!/usr/bin/env bash
# ============================================================================
# W8BDCR Termux Setup — one-command styled Termux
# https://github.com/w8bdcr-official/W8BDCR-Termux-Setup
#
# Installs W8BDCR-TermuxStylePro and applies the W8BDCR look:
#   Style 3  — Matrix
#   Color 1  — Green (Classic Hacker)
#   Name     — w8bdcr-official
#
# Usage:
#   bash install.sh
#   curl -fsSL https://raw.githubusercontent.com/w8bdcr-official/W8BDCR-Termux-Setup/main/install.sh | bash
#
# Customize with environment variables:
#   W8_STYLE=71 W8_NAME=myname W8_COLOR=4 bash install.sh
#   (71 = Kali Linux, 4 = Cyan. See the TermuxStylePro menu for all 100 styles.)
# ============================================================================
set -e

STYLE="${W8_STYLE:-3}"
NAME="${W8_NAME:-w8bdcr-official}"
COLOR="${W8_COLOR:-1}"
REPO_URL="https://github.com/w8bdcr-official/W8BDCR-TermuxStylePro"
TARGET_DIR="$HOME/W8BDCR-TermuxStylePro"

say() { printf '%s\n' "$*"; }

# --- 1. Python + git ---------------------------------------------------------
if command -v pkg >/dev/null 2>&1; then
  say "[1/4] Updating Termux packages..."
  pkg update -y
  pkg install -y python git
else
  say "[1/4] Not Termux — checking python3 and git..."
  command -v python3 >/dev/null 2>&1 || { say "python3 not found — install it first."; exit 1; }
  command -v git >/dev/null 2>&1 || { say "git not found — install it first."; exit 1; }
fi

# --- 2. Get the styler -------------------------------------------------------
if [ -f "$TARGET_DIR/W8TermuxStylePro.py" ]; then
  say "[2/4] W8BDCR-TermuxStylePro already present — using it."
else
  say "[2/4] Cloning W8BDCR-TermuxStylePro..."
  git clone "$REPO_URL" "$TARGET_DIR"
fi

# --- 3. Run the styler (style, name, color — no prompts) ----------------------
say "[3/4] Applying style $STYLE in color $COLOR for $NAME..."
cd "$TARGET_DIR"
if command -v python >/dev/null 2>&1; then PY=python; else PY=python3; fi
printf '%s\n%s\n%s\n' "$STYLE" "$NAME" "$COLOR" | "$PY" W8TermuxStylePro.py

# --- 4. Done -----------------------------------------------------------------
say "[4/4] Done."
say ""
say "To see it now, run:  source ~/.bashrc"
say "Or close and reopen Termux — the banner appears on every start."
