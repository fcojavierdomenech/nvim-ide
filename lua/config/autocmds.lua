-- Autocmds configuration

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General autocmds group
local general = augroup('General', { clear = true })

-- Jump to last position when reopening a file
autocmd('BufReadPost', {
    group = general,
    pattern = '*',
    callback = function()
        local line = vim.fn.line('"')
        if line > 1 and line <= vim.fn.line('$') then
            vim.cmd('normal! g`"')
        end
    end,
})

-- Remove comment continuation on new line
autocmd('FileType', {
    group = general,
    pattern = { 'c', 'cpp', 'php', 'java', 'javascript', 'bash' },
    callback = function()
        vim.opt_local.comments:remove(':// comments')
        vim.opt_local.comments:append('f://')
    end,
})

-- DBUI avoid folding
autocmd('FileType', {
    group = general,
    pattern = 'dbout',
    callback = function()
        vim.opt_local.foldenable = false
    end,
})

-- Set different indentation for different file types
autocmd('FileType', {
    group = general,
    pattern = { 'javascript', 'typescript', 'twig', 'yaml', 'html' },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

autocmd('FileType', {
    group = general,
    pattern = { 'c', 'cpp', 'php', 'java', 'javascript', 'bash' },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- Laravel blade templates recognition
autocmd({ 'BufNewFile', 'BufRead' }, {
    group = general,
    pattern = '*.blade.php',
    callback = function()
        vim.bo.filetype = 'html'
    end,
})

-- TypeScript React files
autocmd({ 'BufNewFile', 'BufRead' }, {
    group = general,
    pattern = { '*.tsx', '*.jsx' },
    callback = function()
        vim.bo.filetype = 'typescriptreact'
    end,
})

-- PHP syntax settings
autocmd('FileType', {
    group = general,
    pattern = 'php',
    callback = function()
        vim.g.php_htmlInStrings = 1  -- Syntax highlight HTML in PHP strings
        vim.g.php_sql_query = 1     -- Syntax highlight SQL in PHP strings
    end,
})

-- Paste mode improvement
autocmd('VimEnter', {
    group = general,
    pattern = '*',
    callback = function()
        vim.keymap.set('n', 'p', 'p=`]`]l', { noremap = true })
    end,
})

-- Rooter functionality
autocmd('BufEnter', {
    group = general,
    pattern = '*',
    callback = function()
        local root_patterns = { '.git', '.project' }
        local current_dir = vim.fn.expand('%:p:h')
        
        while current_dir ~= '/' and current_dir ~= '.' do
            for _, pattern in ipairs(root_patterns) do
                local path = current_dir .. '/' .. pattern
                if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
                    vim.cmd('cd ' .. current_dir)
                    return
                end
            end
            local parent = vim.fn.fnamemodify(current_dir, ':h')
            if parent == current_dir then break end
            current_dir = parent
        end
    end,
})

-- PHP settings autocmd
autocmd('FileType', {
    group = general,
    pattern = 'php',
    callback = function()
        -- Check if it's a Composer project and set omnifunc
        if vim.fn.filereadable('composer.json') == 1 then
            vim.opt_local.omnifunc = 'phpactor#Complete'
        end
    end,
})

-- Open diagnostic float on hover
autocmd('CursorHold', {
    group = general,
    pattern = '*',
    callback = function()
        vim.diagnostic.open_float(nil, { scope = "cursor" })
    end,
})

-- Reload files automatically when they change on disk
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = general,
    pattern = "*",
    callback = function()
        if vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

-- Notification when file changes on disk (optional, autoread handles this mostly silently)
autocmd("FileChangedShellPost", {
    group = general,
    pattern = "*",
    callback = function()
        vim.api.nvim_echo({ { "File changed on disk. Buffer reloaded!", "WarningMsg" } }, true, {})
    end,
})
