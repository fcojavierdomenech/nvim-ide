local M = {}

-- Helper to get all listed buffers
local function get_listed_buffers()
	local buffers = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
			local name = vim.api.nvim_buf_get_name(bufnr)
			if name == "" then
				name = "[No Name]"
			else
				-- Show relative path for better readability
				name = vim.fn.fnamemodify(name, ":~:.")
			end
			table.insert(buffers, { bufnr = bufnr, name = name })
		end
	end
	return buffers
end

function M.open_buffer_manager()
	local buffers = get_listed_buffers()
	local names = {}
	for _, b in ipairs(buffers) do
		table.insert(names, string.format(" %d | %s", b.bufnr, b.name))
	end

	-- Create a scratch buffer for the UI
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, names)
	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].filetype = "buffer_manager"

	-- Calculate window size
	local width = math.min(vim.o.columns - 10, 100)
	local height = math.max(1, math.min(#buffers, vim.o.lines - 10))
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Open floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Buffer Manager ",
		title_pos = "center",
	})

	-- Set highlights
	vim.api.nvim_win_set_option(win, "winhl", "Normal:NormalFloat,FloatBorder:FloatBorder")

	-- Local keymaps
	local function close_window()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	local function get_selected_bufnr()
		local line = vim.api.nvim_win_get_cursor(win)[1]
		local selected = buffers[line]
		return selected and selected.bufnr or nil
	end

	local function delete_buffer()
		local bufnr = get_selected_bufnr()
		if bufnr then
			-- Don't delete the UI buffer itself
			if bufnr == buf then return end
			
			vim.api.nvim_buf_delete(bufnr, { force = true })
			
			-- Refresh the list without closing if possible, but simplest is to reopen
			local current_line = vim.api.nvim_win_get_cursor(win)[1]
			close_window()
			M.open_buffer_manager()
			
			-- Try to restore cursor position
			pcall(vim.api.nvim_win_set_cursor, 0, { math.max(1, current_line - 1), 0 })
		end
	end

	local function activate_buffer()
		local bufnr = get_selected_bufnr()
		if bufnr then
			close_window()
			vim.api.nvim_set_current_buf(bufnr)
		end
	end

	-- Bind keys
	local opts = { buffer = buf, silent = true, noremap = true }
	vim.keymap.set("n", "-", delete_buffer, opts)
	vim.keymap.set("n", "+", activate_buffer, opts)
	vim.keymap.set("n", "<CR>", activate_buffer, opts)
	vim.keymap.set("n", "q", close_window, opts)
	vim.keymap.set("n", "<Esc>", close_window, opts)
end

return M
