-- LSP configuration for Neovim 0.11+

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- Setup mason
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Setup mason-lspconfig
mason_lspconfig.setup({
	ensure_installed = {
		"phpactor",
		"intelephense",
		"ts_ls",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
		"pyright",
		"ruff",
		"gopls",
	},
	automatic_installation = true,
})

-- Global Organize Imports function (Accessible from keymaps)
_G.organize_imports = function()
    local ft = vim.bo.filetype
    if ft == 'php' then
        vim.cmd("PhpactorImportMissingClasses")
    elseif ft == 'python' then
        local ok, conform = pcall(require, "conform")
        if ok then
            -- ruff_fix removes unused imports, ruff_organize_imports sorts them
            conform.format({ formatters = { "ruff_fix", "ruff_organize_imports" } })
        else
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        end
    elseif ft == 'go' then
        local ok, conform = pcall(require, "conform")
        if ok then
            conform.format({ formatters = { "goimports" } })
        else
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        end
    else
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
end

-- Common on_attach function
local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "doc", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Code: Signature help", buffer = bufnr })

	-- Code mappings (Unified under <leader>c)
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code: Rename symbol", buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code: Actions", buffer = bufnr })
	
	-- Workspace
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)

	-- Navigate diagnostics
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Code: Show line diagnostics", buffer = bufnr })
	vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist, { desc = "Code: Diagnostics list", buffer = bufnr })

	-- Toggle diagnostics
	vim.keymap.set("n", "<leader>ctd", function()
		local config = vim.diagnostic.config()
		if config.virtual_text then
			vim.diagnostic.config({ virtual_text = false, signs = false, underline = false })
			vim.diagnostic.hide()
		else
			vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
			vim.diagnostic.show()
		end
	end, { desc = "Code: Toggle diagnostics", buffer = bufnr })
end

-- Configure diagnostics
vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		wrap = true,
		max_width = 80,
	},
})

-- Auto-show diagnostics only on save
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
		})
		vim.diagnostic.show()
		vim.defer_fn(function()
			vim.diagnostic.config({
				virtual_text = false,
				signs = false,
				underline = false,
			})
			vim.diagnostic.hide()
		end, 3000)
	end,
})

-- Capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Server configurations using the new vim.lsp.config (Neovim 0.11+)
local servers = {
	phpactor = {},
	intelephense = {
		settings = {
			intelephense = {
				files = { maxSize = 1000000 },
			},
		},
	},
	ts_ls = {},
	html = {},
	cssls = {},
	jsonls = {},
	yamlls = {},
	ruff = {},
	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					autoImportCompletions = true, -- Habilitar sugerencias de importación
					indexing = true, -- Indexar paquetes para encontrar imports más rápido
					typeCheckingMode = "basic",
				},
			},
		},
	},
	gopls = {
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
			},
		},
	},
}

-- Apply configurations
for server, config in pairs(servers) do
	config.on_attach = on_attach
	config.capabilities = capabilities
	
	-- Using the new Neovim 0.11+ API
	if vim.lsp.config then
		vim.lsp.config[server] = config
		vim.lsp.enable(server)
	else
		require("lspconfig")[server].setup(config)
	end
end
