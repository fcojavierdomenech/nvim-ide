-- PHP Neovim Configuration in Lua
-- Modern conversion of vimrc-php to Lua

-- Ensure compatibility
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = vim.fn.exepath("python3")

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load configuration modules
require("config.options")
require("config.autocmds")
require("config.plugins")
require("config.keymaps")
require("config.colorscheme")

-- Syntax highlighting
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Create undodir if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- Setup Tokyo Night with custom options
require("tokyonight").setup({
	style = "moon", -- The theme comes in three styles, `storm`, `moon`, `night` and `day`
	transparent = true, -- Enable this to use terminal background
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent",
		floats = "transparent",
	},
	-- Disable all bold text for a "lighter" feel
	on_highlights = function(hl, c)
		for _, group in pairs(hl) do
			if group.bold then
				group.bold = false
			end
		end

		-- Customizing floating windows background
		-- We make it a bit lighter than the normal background for better contrast
		hl.NormalFloat = {
			bg = c.bg_highlight, -- Use a slightly lighter background from the palette
		}
		hl.FloatBorder = {
			bg = c.bg_highlight,
			fg = c.border_highlight,
		}
	end,
})

vim.cmd.colorscheme("tokyonight-moon")

-- Configure clipboard for Wayland if detected
-- if os.getenv("WAYLAND_DISPLAY") ~= nil then
vim.g.clipboard = {
	name = "wl-copy",
	copy_command = "wl-copy",
	paste_command = "wl-paste",
	cache_enabled = 1,
}
-- else
-- Fallback for X11 or other environments
vim.opt.clipboard = "unnamedplus"
--end
