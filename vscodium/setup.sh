cat << 'EOF' > ~/dotfiles/setup.sh
#!/bin/bash

# Configuration
REPO_URL="https://github.com/khan-debug/VS-Code-Minimal-Setup.git"
DOTFILES_DIR="$HOME/dotfiles"
VSC_SOURCE="$DOTFILES_DIR/vscodium"
VSC_TARGET="$HOME/.config/VSCodium/User"

# 1. Clone or Update Repository
if [ -d "$DOTFILES_DIR/.git" ]; then
    echo "Updating existing dotfiles..."
    git -C "$DOTFILES_DIR" pull
else
    echo "Cloning dotfiles..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# 2. Ensure Target Directory Exists
mkdir -p "$VSC_TARGET"

# 3. Create Symlinks
echo "Symlinking settings..."
ln -sf "$VSC_SOURCE/settings.json" "$VSC_TARGET/settings.json"
ln -sf "$VSC_SOURCE/keybindings.json" "$VSC_TARGET/keybindings.json"

# 4. Install Extensions
if [ -f "$VSC_SOURCE/extensions.txt" ]; then
    echo "Installing extensions..."
    xargs -n 1 codium --install-extension < "$VSC_SOURCE/extensions.txt"
fi

echo "VSCodium sync complete."
EOF

chmod +x ~/dotfiles/setup.sh
