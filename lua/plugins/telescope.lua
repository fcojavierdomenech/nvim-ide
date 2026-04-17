-- Telescope configuration

local telescope = require('telescope')

local function get_project_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir = vim.fn.fnamemodify(current_file, ':h')
    local git_dir = vim.fn.finddir('.git', current_dir .. ';') -- find .git up the hierarchy
    local project_file = vim.fn.findfile('.project', current_dir .. ';') -- find .project up the hierarchy

    local project_root = ''
    if git_dir ~= '' then
        project_root = vim.fn.fnamemodify(git_dir, ':h') -- return parent directory of .git
    elseif project_file ~= '' then
        project_root = vim.fn.fnamemodify(project_file, ':h') -- return parent directory of .project
    else
        project_root = vim.fn.getcwd() -- fallback to current working directory
    end
    return project_root
end

-- Export function for use in other files
telescope.get_project_root = get_project_root

-- Setup telescope
telescope.setup({
    defaults = {
        prompt_prefix = '🔍 ',
        selection_caret = ' ',
        path_display = { 'truncate' },
        file_ignore_patterns = {
            'node_modules',
            '.git/',
            'vendor/',
            '*.min.js',
            '*.min.css',
        },
    },
    pickers = {
        find_files = {
            theme = 'dropdown',
            previewer = false,
            cwd = get_project_root(),
        },
        live_grep = {
            theme = 'dropdown',
            cwd = get_project_root(),
        },
        buffers = {
            theme = 'dropdown',
            previewer = false,
        },
    },
})

-- Keymaps
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').find_files({ cwd = get_project_root() }) end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>s', function() require('telescope.builtin').live_grep({ cwd = get_project_root() }) end, { desc = 'Live Grep (Global Search)' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>fr', function() require('telescope.builtin').oldfiles() end, { desc = 'Recent Files' })
vim.keymap.set('n', '<leader>fc', function() require('telescope.builtin').commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fk', function() require('telescope.builtin').keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fs', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = 'Buffer Search' })

-- Git pickers
vim.keymap.set('n', '<leader>gc', function() require('telescope.builtin').git_commits() end, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_branches() end, { desc = 'Git Branches' })
vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end, { desc = 'Git Status' })

-- LSP pickers
vim.keymap.set('n', '<leader>lr', function() require('telescope.builtin').lsp_references() end, { desc = 'LSP References' })
vim.keymap.set('n', '<leader>ld', function() require('telescope.builtin').lsp_definitions() end, { desc = 'LSP Definitions' })
vim.keymap.set('n', '<leader>ls', function() require('telescope.builtin').lsp_document_symbols() end, { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>lw', function() require('telescope.builtin').lsp_workspace_symbols() end, { desc = 'Workspace Symbols' })return telescope
