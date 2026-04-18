# PHP Lua Neovim Configuration (Tokyo Night Moon)

Modern Lua-based Neovim configuration optimized for PHP and Web development, featuring a clean aesthetic inspired by Gemini-CLI.

## 🎨 Appearance & UX
- **Theme**: [Tokyo Night Moon](https://github.com/folke/tokyonight.nvim) (Dark, soft, and modern).
- **No Bold**: Configured to remove bold text (`bold = false`) for reduced visual strain.
- **Transparency**: Respects your terminal background.
- **Statusline**: Airline configured to be informative yet discreet.
- **Indentation Guides**: [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) for better code structure visualization.

## 🚀 Installation

### 1. Prerequisites
Ensure you have the following installed:
- **Neovim (0.9+)**
- **Ripgrep** (for Telescope search)
- **Node.js & npm** (for most LSP servers)
- **Composer** (for PHP specific tools)
- **Go & gopls** (for Go support)
- **Nerd Font** (REQUIRED for icons, e.g., JetBrainsMono Nerd Font)

#### MacOS (using Homebrew)
```bash
# Install core tools
brew install neovim ripgrep node composer go

# Install gopls
go install golang.org/x/tools/gopls@latest

# Install Nerd Font (Fixes [?] icons)
brew install --cask font-jetbrains-mono-nerd-font
```

> **CRITICAL**: After installing the font, you MUST set your Terminal's font to `JetBrainsMono Nerd Font` in its settings (Profiles -> Text -> Font), otherwise icons will appear as `?`.

#### Linux (Ubuntu/Debian)
```bash
sudo apt install neovim ripgrep nodejs npm composer
# Download a Nerd Font from https://www.nerdfonts.com/font-downloads
```

### 2. Install Configuration
Clone this repository and run the installer:
```bash
git clone https://github.com/fcojavierdomenech/nvim-ide.git ~/.config/nvim-source
cd ~/.config/nvim-source
./install.sh
```
*Note: The installer will backup your existing `~/.config/nvim` if it exists.*

## 🔍 Search & Navigation (Telescope)
Automatically detects project roots by searching for `.git` folders or `.project` files.

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>f` | **Find Files** | Search for files by name. |
| `<leader>s` | **Live Grep** | Search for text across the project. |
| `<leader>fb`| **Buffers** | List currently open files. |
| `<leader>fr`| **Recent Files**| View recently used files. |
| `<leader>gs`| **Git Status** | View modified files in the repo. |
| `<leader>e` | **Explorer** | Toggle NvimTree sidebar. |
| `<leader>n` | **Explorer** | Toggle NvimTree sidebar (alternative). |

## 💡 Code Intelligence (LSP)
Native support for PHP (Phpactor), JS/TS, Python, etc.

| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition. |
| `gr` | Find all references. |
| `K`  | View documentation/signature. |
| `<leader>rn` | Rename symbol. |
| `<leader>ca` | Code Actions. |
| `]d` / `[d` | Next/Previous error. |


### Go Support (gopls)
Native support for Go development via `gopls`.
- **To enable**: Follow the installation steps in Prerequisites and ensure `export PATH=$PATH:$(go env GOPATH)/bin` is in your `.zshrc`.
- **To disable**: Simply do not install `gopls`.

### 🤖 AI Assistance (GitHub Copilot)
The official GitHub Copilot plugin is integrated.
- **Setup**: To authenticate (especially for the free plan), run `:Copilot setup` inside Neovim.
- **Keybindings**: `Ctrl + y` to accept suggestions.

### PHP Specific (Phpactor)
- `<leader>u`: Automatically add `use` statements.
- `<leader>mm`: Phpactor context menu.
- Auto-import missing classes on save.

## 🛠️ Editing Tools
- **YankRing (`<F9>`)**: Clipboard history.
- **Comment.nvim**: `gcc` to comment lines, `gc` for blocks.
- **Surround**: `cs"'` to change quotes, `ysiw(` to surround word with parentheses.
- **Undotree**: Visual and persistent undo history.
- **Magma**: Jupyter-style code execution.
- **ToggleTerm (`<F1>` / `<C-\>`)**: Integrated floating terminal.

## 📁 Project Structure
```
.config/nvim/
├── init.lua            # Entry point (Loads theme and core options)
├── lua/
│   ├── config/
│   │   ├── plugins.lua    # Plugin list (lazy.nvim)
│   │   ├── keymaps.lua    # Global keybindings
│   │   ├── options.lua    # Vim options (indentation, etc.)
│   │   └── autocmds.lua   # Autocommands (Rooter, etc.)
│   └── plugins/        # Specific plugin configurations
│       ├── telescope.lua
│       ├── lsp.lua
│       └── ...
```

## 🚀 Dependencies
Ensure you have the following installed for full functionality:
- `ripgrep` (for Telescope)
- `npm/nodejs` (for LSP servers)
- `composer` (for PHP tools)
- `go` & `gopls` (for Go support)
- `Nerd Fonts` (for icons)
