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
    format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
})

-- Format commands
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting globally
        vim.g.disable_autoformat = true
        print("Autoformat on save disabled globally")
    else
        vim.b.disable_autoformat = true
        print("Autoformat on save disabled for this buffer")
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    print("Autoformat on save enabled")
end, {
    desc = "Re-enable autoformat-on-save",
})

-- Format command manually
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



-- Indentation commands
vim.api.nvim_create_user_command("Tab2spaces", function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    print("Indentation set to 2 spaces")
end, { desc = "Set indentation to 2 spaces" })

vim.api.nvim_create_user_command("Tab4spaces", function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    print("Indentation set to 4 spaces")
end, { desc = "Set indentation to 4 spaces" })
