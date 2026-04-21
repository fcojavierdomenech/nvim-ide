-- Phpactor configuration

-- Unified Code mappings (starting with <leader>c)
vim.keymap.set("n", "<Leader>cu", ":call phpactor#UseAdd()<CR>", { desc = "Code: Add Use Statement (PHP)" })
vim.keymap.set("n", "<Leader>cm", ":call phpactor#ContextMenu()<CR>", { desc = "Code: Context Menu (PHP)" })
vim.keymap.set("n", "<Leader>cn", ":call phpactor#Navigate()<CR>", { desc = "Code: Navigate (PHP)" })
vim.keymap.set("n", "<Leader>ct", ":call phpactor#Transform()<CR>", { desc = "Code: Transform/Refactor (PHP)" })
vim.keymap.set("n", "<Leader>cN", ":call phpactor#ClassNew()<CR>", { desc = "Code: New Class (PHP)" })
vim.keymap.set("n", "<Leader>cx", ":call phpactor#ClassExpand()<CR>", { desc = "Code: Class Expand (PHP)" })

-- Extraction remains under <leader>r for consistency with other languages
vim.keymap.set("n", "<Leader>re", ":call phpactor#ExtractExpression(v:false)<CR>", { desc = "Refactor: Extract Expression (PHP)" })
vim.keymap.set("v", "<Leader>re", ":<C-U>call phpactor#ExtractExpression(v:true)<CR>", { desc = "Refactor: Extract Expression (PHP)" })
vim.keymap.set("v", "<Leader>rm", ":<C-U>call phpactor#ExtractMethod()<CR>", { desc = "Refactor: Extract Method (PHP)" })

-- Others
vim.keymap.set("n", "<S-i>", ":call phpactor#Hover()<CR>", { desc = "Hover Info" })


vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		local char = vim.v.char
		if char == "(" or char == "," then
			vim.defer_fn(function()
				vim.lsp.buf.signature_help()
			end, 0)
		end
	end,
})

-- Auto-import missing classes on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.php",
	command = "PhpactorImportMissingClasses",
})

-- Set omnifunc for Composer projects
vim.api.nvim_create_autocmd("FileType", {
	pattern = "php",
	callback = function()
		if vim.fn.filereadable("composer.json") == 1 then
			vim.opt_local.omnifunc = "phpactor#Complete"
		end
	end,
})
