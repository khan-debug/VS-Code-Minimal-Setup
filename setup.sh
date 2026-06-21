#!/bin/bash

# Configuration
REPO_URL="https://github.com/khan-debug/VS-Code-Minimal-Setup.git"
SETUP_DIR="$HOME/VS-Code-Minimal-Setup"
VSC_SOURCE="$SETUP_DIR/vscodium"
VSC_TARGET="$HOME/.config/VSCodium/User"

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
    if ! command -v codium &>/dev/null; then
        echo "Warning: 'codium' not found in PATH. Skipping extension install."
    else
        echo "Installing extensions..."
        grep -v '^\s*$\|^\s*#' "$VSC_SOURCE/extensions.txt" | xargs -n 1 codium --install-extension
    fi
fi

echo "VSCodium sync complete."
