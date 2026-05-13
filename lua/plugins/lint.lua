-- Lint configuration with nvim-lint

local lint = require('lint')

-- Configure linters
lint.linters_by_ft = {
    javascript = {'eslint'},
    typescript = {'eslint'},
    json = {'jsonlint'},
    yaml = {'yamllint'},
    python = {'flake8'},
    go = {'golangci-lint'},
}

-- Lint commands
vim.api.nvim_create_user_command("LintDisable", function(args)
    if args.bang then
        vim.g.disable_linting = true
        print("Linting disabled globally")
    else
        vim.b.disable_linting = true
        print("Linting disabled for this buffer")
    end
end, {
    desc = "Disable linting",
    bang = true,
})

vim.api.nvim_create_user_command("LintEnable", function()
    vim.b.disable_linting = false
    vim.g.disable_linting = false
    print("Linting enabled")
end, {
    desc = "Re-enable linting",
})

-- Auto-lint only on save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback = function()
        -- Skip if disabled
        if vim.g.disable_linting or vim.b.disable_linting then
            return
        end

        -- Check if linter executable exists to avoid ENOENT errors
        local ft = vim.bo.filetype
        local linters = lint.linters_by_ft[ft] or {}
        for _, linter in ipairs(linters) do
            if vim.fn.executable(linter) == 0 then
                -- If the main linter for this filetype is missing, skip try_lint
                -- to avoid the "ENOENT" error message
                return
            end
        end

        pcall(require('lint').try_lint)
    end,
})

