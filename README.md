# PHP Lua Neovim Configuration (Tokyo Night Moon)

Modern Lua-based Neovim configuration optimized for PHP and Web development, featuring a clean aesthetic inspired by Gemini-CLI.

## 🎨 Appearance & UX
- **Theme**: [Tokyo Night Moon](https://github.com/folke/tokyonight.nvim) (Dark, soft, and modern).
- **No Bold**: Configured to remove bold text (`bold = false`) for reduced visual strain.
- **Transparency**: Respects your terminal background.
- **Statusline**: Airline configured to be informative yet discreet.
- **Indentation Guides**: [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) for better code structure visualization.

## 🔍 Search & Navigation (Telescope)
Automatically detects project roots by searching for `.git` folders or `.project` files.

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>f` | **Find Files** | Search for files by name within the project. |
| `<leader>s` | **Live Grep** | Search for text/regex across the entire project. |
| `<leader>r` | **Old Files** | MRU: Recently used files (history). |
| `:M` | **Old Files** | Quick command for history (MRU). |
| `<leader>fb` | **Buffers** | List currently open files. |
| `<leader>gs` | **Git Status** | View modified files in the repository. |
| `<leader>n` | **Explorer** | Toggle NvimTree (sidebar file explorer). |

## 💡 Code Intelligence (LSP)
Native support for PHP (Phpactor/Intelephense), JS/TS, Python, HTML/CSS, etc.

| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition. |
| `gr` | Find all references. |
| `doc` | View documentation/signature under cursor. |
| `<leader>rn` | Rename symbol project-wide. |
| `<leader>ca` | Code Actions (quick fixes). |
| `]d` / `[d` | Next/Previous error or warning. |

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
- `Nerd Fonts` (for icons)
