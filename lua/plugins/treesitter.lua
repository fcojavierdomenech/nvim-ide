-- Treesitter configuration (Updated for nvim-treesitter rewrite)

local ts = require('nvim-treesitter')

ts.setup({
    -- You can specify install_dir if you want, but default is usually fine
})

-- Install parsers
ts.install({
    'php',
    'python',
    'go',
    'gomod',
    'javascript',
    'typescript',
    'html',
    'css',
    'scss',
    'json',
    'yaml',
    'lua',
    'vim',
    'bash',
    'sql',
    'dockerfile',
    'vue',
    'markdown',
    'markdown_inline',
})

-- Enable highlighting for all supported languages
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        -- Skip special buffers like Telescope, NvimTree, etc.
        if vim.bo.buftype ~= "" then return end
        
        local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
        if lang == "" or lang:find("Telescope") then return end

        local ok, _ = pcall(vim.treesitter.get_parser, 0, lang)
        if ok then
            local has_query = pcall(vim.treesitter.query.get, lang, 'highlights')
            if has_query then
                pcall(vim.treesitter.start, 0, lang)
            end
        end
    end,
})

-- Enable indentation
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        -- Skip special buffers
        if vim.bo.buftype ~= "" then return end

        local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
        if lang == "" or lang:find("Telescope") then return end

        local ok, _ = pcall(vim.treesitter.get_parser, 0, lang)
        if ok then
            local has_query = pcall(vim.treesitter.query.get, lang, 'indents')
            if has_query then
                vim.opt_local.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            end
        end
    end,
})
