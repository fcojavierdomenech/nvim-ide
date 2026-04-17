#!/bin/bash
# Check dependencies for Go, LuaSnip update, and Phpactor

echo "--- Checking Go (for gopls and treesitter) ---"
if ! command -v go &> /dev/null; then
    echo "MISSING: go. Run: sudo pacman -S go"
else
    echo "OK: go is installed."
fi

echo -e "\n--- Checking PHP iconv (for phpactor) ---"
if ! php -m | grep -qi iconv; then
    echo "MISSING: PHP iconv extension."
    echo "Check if it's installed (sudo pacman -S php-iconv) and enabled in /etc/php/php.ini"
else
    echo "OK: PHP iconv is enabled."
fi

echo -e "\n--- Checking LuaSnip local changes ---"
LUASNIP_DIR="$HOME/.local/share/nvim/lazy/LuaSnip"
if [ -d "$LUASNIP_DIR" ]; then
    echo "Resetting $LUASNIP_DIR to clean state..."
    (cd "$LUASNIP_DIR" && git reset --hard HEAD && git clean -fd)
    # Aggressively remove problematic deps/jsregexp if it's a source of trouble
    [ -d "$LUASNIP_DIR/deps/jsregexp" ] && rm -rf "$LUASNIP_DIR/deps/jsregexp"
    echo "OK: LuaSnip should be ready for update in Neovim."
else
    echo "INFO: LuaSnip directory not found at $LUASNIP_DIR (maybe not installed yet)."
fi
