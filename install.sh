#!/bin/bash

# PHP Lua Neovim Configuration Installer

set -e

echo "🚀 Installing PHP Lua Neovim Configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    print_error "Neovim is not installed. Please install Neovim 0.8+ first."
    exit 1
fi

# Check Neovim version
nvim_version=$(nvim --version | head -n1 | cut -d' ' -f2 | cut -d'v' -f2)
print_status "Found Neovim version: $nvim_version"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_warning "Node.js is not installed. Some LSP features may not work."
else
    node_version=$(node --version)
    print_status "Found Node.js version: $node_version"
fi

# Check if PHP is installed
if ! command -v php &> /dev/null; then
    print_warning "PHP is not installed. PHP LSP features may not work."
else
    php_version=$(php --version | head -n1 | cut -d' ' -f2)
    print_status "Found PHP version: $php_version"
fi

# Check if Composer is installed
if ! command -v composer &> /dev/null; then
    print_warning "Composer is not installed. Some PHP features may not work."
else
    print_status "Found Composer"
fi

# Check if ripgrep is installed
if ! command -v rg &> /dev/null; then
    print_warning "Ripgrep is not installed. Telescope live grep may not work."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_status "Install with: brew install ripgrep"
    else
        print_status "Install with: sudo pacman -S ripgrep (Arch) or sudo apt install ripgrep (Ubuntu)"
    fi
else
    print_status "Found ripgrep"
fi

# Backup existing configuration
if [ -d "$HOME/.config/nvim" ]; then
    backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    print_status "Backing up existing Neovim configuration to $backup_dir"
    mv "$HOME/.config/nvim" "$backup_dir"
    print_success "Backup created at $backup_dir"
fi

# Create nvim config directory
print_status "Creating Neovim configuration directory..."
mkdir -p "$HOME/.config/nvim"

# Copy configuration files (excluding git and transient files)
print_status "Copying configuration files..."
if command -v rsync &> /dev/null; then
    rsync -av --exclude '.git/' \
              --exclude '.aider.chat.history.md' \
              --exclude 'Vout.log' \
              --exclude 'CONVERSION_SUMMARY.md' \
              --exclude 'nvim-ide/' \
              --exclude 'repro_go.sh' \
              --exclude 'structure.md' \
              --exclude 'install.sh' \
              ./ "$HOME/.config/nvim/"
else
    print_warning "rsync not found, using cp (this may include unwanted files)."
    cp -r ./* "$HOME/.config/nvim/"
fi

# Create undodir if it doesn't exist
mkdir -p "$HOME/.vim/undodir"

print_success "Configuration files installed successfully!"

echo ""
echo "🎉 Installation Complete!"
echo ""
echo "Next steps:"
echo "1. Start Neovim: nvim"
echo "2. Wait for lazy.nvim to install plugins automatically"
echo "3. Run :Mason to install language servers if needed"
echo "4. Install a Nerd Font for proper icon display"
echo ""
echo "Key mappings:"
echo "  <Space> - Leader key"
echo "  <leader>ff - Find files"
echo "  <leader>fg - Live grep"
echo "  <leader>e - Toggle file explorer"
echo "  gd - Go to definition"
echo "  K - Hover documentation"
echo ""
echo "For more information, see the README.md file."
echo ""
print_success "Happy coding! 🚀"

