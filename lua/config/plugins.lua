-- Plugin configuration using lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
	-- Colorschemes
	{
		"flazz/vim-colorschemes",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon", -- "storm", "moon", "night" o "day"
			transparent = true, -- para que use el fondo de tu terminal
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},

	-- Which Key - Show keybindings
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.whichkey")
		end,
	},

	-- Airline statusline
	{
		"vim-airline/vim-airline",
		dependencies = { "vim-airline/vim-airline-themes" },
		config = function()
			require("plugins.airline")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.nvim-tree")
		end,
	},

	-- Commenting
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>cc",
					block = "<leader>cb",
				},
				opleader = {
					line = "<leader>cc",
					block = "<leader>cb",
				},
			})
		end,
	},

	-- Repeat plugin commands
	"tpope/vim-repeat",
	{
		"dccsillag/magma-nvim",
		config = function()
			vim.g.magma_output_window_borders = false
		end,
	},

	-- PHP syntax
	"StanAngeloff/php.vim",

	-- Twig syntax
	"evidens/vim-twig",

	-- YankRing
	"vim-scripts/YankRing.vim",

	-- Extended % matching
	"vim-scripts/matchit.zip",

	-- Line diff
	"AndrewRadev/linediff.vim",

	-- Macros
	"vim-scripts/marvim",

	-- Restore view
	"vim-scripts/restore_view.vim",

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("plugins.luasnip")
		end,
	},

	-- Git plugins
	"tpope/vim-fugitive",
	"gregsexton/gitv",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Surround
	"tpope/vim-surround",

	-- Search with ripgrep
	"BurntSushi/ripgrep",

	-- Project replace
	"skwp/greplace.vim",
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			require("plugins.grug-far")
		end,
	},

	-- Word substitutions
	"tpope/vim-abolish",

	-- Dev icons
	"ryanoasis/vim-devicons",

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
		end,
	},

	-- Undo tree
	{
		"mbbill/undotree",
		config = function()
			vim.g.undotree_WindowLayout = 2
		end,
	},

	-- Testing
	"vim-test/vim-test",

	-- Database
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-ui",

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	},

	-- Phpactor
	{
		"phpactor/phpactor",
		ft = "php",
		build = "composer install --no-dev",
		config = function()
			require("plugins.phpactor")
		end,
	},

	-- Vue
	"leafOfTree/vim-vue-plugin",

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- TypeScript/React
	"leafgarland/typescript-vim",
	"peitalin/vim-jsx-typescript",

	-- Jump to location
	{
		url = "https://codeberg.org/andyg/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	-- LSP and completion
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.lsp")
			require("plugins.completion")
		end,
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},

	-- GitHub Copilot
	{
		"github/copilot.vim",
		enabled = true,
	},

	-- Amazon Q Developer
	{
		"awslabs/amazonq.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("amazonq").setup({
				-- REQUIRED: SSO portal URL for authentication
				ssoStartUrl = "https://view.awsapps.com/start",
			})
		end,
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end,
	},

	-- Syntax checking replacement for syntastic
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("plugins.lint")
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		config = function()
			require("plugins.formatting")
		end,
	},

	-- Debug Adapter Protocol (DAP)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("plugins.dap")
		end,
	},

	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user .",
		config = function()
			require("plugins.jupynium")
		end,
	},
	-- Optional:
	"rcarriga/nvim-notify",
	"stevearc/dressing.nvim",
})
