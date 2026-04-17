-- Keymaps configuration (converted from mappings.vimrc)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Helper function to merge options with a description
local function desc(description)
	return { noremap = true, silent = true, desc = description }
end

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better navigation
keymap("n", "j", "gj", desc("Move down (wrap lines)"))
keymap("n", "k", "gk", desc("Move up (wrap lines)"))

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", desc("Move focus to left window"))
keymap("n", "<C-j>", "<C-w>j", desc("Move focus to window below"))
keymap("n", "<C-k>", "<C-w>k", desc("Move focus to window above"))
keymap("n", "<C-l>", "<C-w>l", desc("Move focus to right window"))
keymap("n", "<S-h>", "<C-w>h", desc("Move focus to left window (Shift)"))
keymap("n", "<S-j>", "<C-w>j", desc("Move focus to window below (Shift)"))
keymap("n", "<S-k>", "<C-w>k", desc("Move focus to window above (Shift)"))
keymap("n", "<S-l>", "<C-w>l", desc("Move focus to right window (Shift)"))

-- Bracket navigation
keymap("n", "{", "[{}", desc("Jump to previous { brace"))
keymap("n", "}", "]}", desc("Jump to next } brace"))
keymap("v", "{", "[{}", desc("Visual: Jump to previous { brace"))
keymap("v", "}", "]}", desc("Visual: Jump to next } brace"))

-- Diff navigation
keymap("n", "dn", "]c", desc("Next diff hunk"))
keymap("n", "dN", "[c", desc("Previous diff hunk"))

-- Exit insert mode
keymap("i", "jk", "<Esc>", desc("Exit insert mode (jk)"))
keymap("i", "kj", "<Esc>", desc("Exit insert mode (kj)"))

-- Suspend vim
keymap("i", "<C-z>", "<Esc><C-z>", desc("Suspend Neovim (background)"))

-- Auto-close braces
keymap("i", "{<Enter>", "{<Enter>}<Esc><Up>o", desc("Auto-close brace and new line"))

-- Surround in visual mode
keymap("v", "s", "S", desc("Surround selection (vim-surround)"))

-- Case/Character manipulation
keymap("n", "+", "/\\w\\+_<CR>", desc("Search for next snake_case"))
keymap("n", "-", "f_x~", desc("Convert snake_case to camelCase under cursor"))

-- Show list characters
keymap("n", "<F12>", [[:set list lcs=tab:|\ <CR>]], desc("Toggle visible whitespace/tabs"))

-- YankRing
keymap("n", "<F9>", ":YRShow<CR>", desc("Show YankRing history (normal mode)"))
keymap("i", "<F9>", "<Esc>:YRShow<CR>", desc("Show YankRing history (insert mode)"))

-- Test strategy
vim.g["test#strategy"] = "neovim"

-- Wild menu navigation
keymap("n", "<F4>", ":emenu <C-Z>", desc("Open wildmenu / emenu"))

-- Syntax highlight info
keymap("n", "<Leader>hi", function()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local hi = vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
	local trans = vim.fn.synIDattr(vim.fn.synID(line, col, 0), "name")
	local lo = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col, 1)), "name")
	print("hi<" .. hi .. "> trans<" .. trans .. "> lo<" .. lo .. ">")
end, desc("Inspect syntax highlight group under cursor"))

-- HTML encode/decode (requires perl)
keymap("n", "<Leader>h", ":silent %!perl -CIO -MHTML::Entities -pe '$_=encode_entities $_'<CR>", desc("HTML Encode buffer (normal)"))
keymap("v", "<Leader>h", ":silent '<,'>!perl -CIO -MHTML::Entities -pe '$_=encode_entities $_'<CR>", desc("HTML Encode selection (visual)"))
keymap("n", "<Leader>H", ":silent %!perl -CI -MHTML::Entities -pe '$_=decode_entities $_'<CR>", desc("HTML Decode buffer (normal)"))
keymap("v", "<Leader>H", ":silent '<,'>!perl -CI -MHTML::Entities -pe '$_=decode_entities $_'<CR>", desc("HTML Decode selection (visual)"))

-- English keyboard mappings
keymap("i", "ç", "->", desc("Quick arrow (ç -> ->)"))
keymap("i", "Ç", "\\", desc("Quick backslash (Ç -> \\)"))
keymap("i", "<S-z>Z", "<", desc("Quick < symbol"))
keymap("i", "<S-x>X", ">", desc("Quick > symbol"))
keymap("n", "<S-z>", "<", desc("Move/Shift line left"))
keymap("n", "<S-x>", ">", desc("Move/Shift line right"))

-- MRU
vim.api.nvim_create_user_command("M", "Telescope oldfiles", {})
vim.api.nvim_create_user_command("MV", "vsplit | Telescope oldfiles", {})
vim.api.nvim_create_user_command("MH", "split | Telescope oldfiles", {})

-- Explorer
keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", desc("Toggle NvimTree File Explorer"))

-- Refactoring (refactoring.nvim)
keymap({"n", "x"}, "<leader>rr", function() require('refactoring').select_refactor() end, desc("Refactor: Show menu"))
keymap("x", "<leader>re", ":Refactor extract ", desc("Refactor: Extract selection to function"))
keymap("x", "<leader>rf", ":Refactor extract_to_file ", desc("Refactor: Extract selection to file"))
keymap("x", "<leader>rv", ":Refactor extract_var ", desc("Refactor: Extract selection to variable"))
keymap("n", "<leader>rl", ":Refactor inline_var", desc("Refactor: Inline (mOve) variable into use"))
keymap("n", "<leader>ri", function() _G.organize_imports() end, desc("Refactor: Organize/Clean Imports"))
keymap("n", "<leader>rb", ":Refactor extract_block", desc("Refactor: Extract block to function"))
keymap("n", "<leader>rfb", ":Refactor extract_block_to_file", desc("Refactor: Extract block to file"))
keymap("n", "<leader>rc", ":PhpactorExtractConstant<CR>", desc("Refactor: Extract Constant (PHP Only)"))

-- Magma evaluation
keymap("n", "<leader>ml", ":MagmaEvaluateLine<CR>", desc("Magma: Evaluate current line"))
keymap("v", "<leader>mv", ":<C-u>MagmaEvaluateVisual<CR>", desc("Magma: Evaluate visual selection"))

-- Copilot
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
	silent = true,
	expr = true,
	replace_keycodes = false,
    desc = "Copilot: Accept suggestion"
})

-- Commenting & Documentation
keymap("n", "<Leader>cc", "gcc", { remap = true, desc = "Code: Toggle line comment" })
keymap("v", "<Leader>cc", "gc", { remap = true, desc = "Code: Toggle selection comment" })
keymap("n", "<Leader>cb", "gbc", { remap = true, desc = "Code: Toggle block comment" })
keymap("v", "<Leader>cb", "gb", { remap = true, desc = "Code: Toggle selection block comment" })
keymap("v", "<Leader>cd", 'S"""', { remap = true, desc = "Code: Wrap in Docstring (\"\"\")" })
