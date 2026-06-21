#!/bin/bash

# Editor selection: interactive menu when no arg, direct if specified
EDITOR="${1:-}"

if [ -z "$EDITOR" ]; then
  echo "Select editor to configure:"
  echo "  1) VS Code"
  echo "  2) VSCodium"
  echo -n "Choice [1-2]: "
  read -r choice
  case "$choice" in
    1) EDITOR="code" ;;
    2) EDITOR="codium" ;;
    *) echo "Invalid choice. Defaulting to codium."; EDITOR="codium" ;;
  esac
fi

case "$EDITOR" in
  code)
    VSC_SOURCE_DIR="vscode"
    VSC_TARGET="$HOME/.config/Code/User"
    CLI="code"
    NAME="VS Code"
    ;;
  codium)
    VSC_SOURCE_DIR="vscodium"
    VSC_TARGET="$HOME/.config/VSCodium/User"
    CLI="codium"
    NAME="VSCodium"
    ;;
  *)
    echo "Usage: $0 [code|codium]"
    exit 1
    ;;
esac

# Configuration
REPO_URL="https://github.com/khan-debug/VS-Code-Minimal-Setup.git"
SETUP_DIR="$HOME/VS-Code-Minimal-Setup"
VSC_SOURCE="$SETUP_DIR/$VSC_SOURCE_DIR"

# 1. Clone or Update Repository
if [ -d "$SETUP_DIR/.git" ]; then
    echo "Updating existing setup..."
    git -C "$SETUP_DIR" pull
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$SETUP_DIR"
fi

# 2. Ensure Target Directory Exists
mkdir -p "$VSC_TARGET"

# 3. Create Symlinks
echo "Symlinking settings..."
ln -sf "$VSC_SOURCE/settings.json" "$VSC_TARGET/settings.json"

# 4. Install Extensions
if [ -f "$VSC_SOURCE/extensions.txt" ]; then
    if ! command -v "$CLI" &>/dev/null; then
        echo "Warning: '$CLI' not found in PATH. Skipping extension install."
    else
        echo "Installing extensions..."
        grep -v '^\s*$\|^\s*#' "$VSC_SOURCE/extensions.txt" | xargs -n 1 "$CLI" --install-extension
    fi
fi

echo "$NAME sync complete."
