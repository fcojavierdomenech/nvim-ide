-- Formatting configuration with conform.nvim

local conform = require('conform')

conform.setup({
    formatters_by_ft = {
        php = {'php_cs_fixer'},
        python = {'ruff_fix', 'ruff_organize_imports', 'ruff_format'},
        go = {'goimports', 'gofumpt'},
        javascript = {'prettier'},
        typescript = {'prettier'},
        html = {'prettier'},
        css = {'prettier'},
        json = {'prettier'},
        yaml = {'prettier'},
        lua = {'stylua'},
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

-- Format command
vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = {args.line1, 0},
            ['end'] = {args.line2, end_line:len()},
        }
    end
    conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

-- Format keymap (Unified under <leader>c for Code)
vim.keymap.set({'n', 'v'}, '<leader>cf', function()
    conform.format({ async = true, lsp_fallback = true })
end, { desc = 'Code: Format buffer/selection' })
