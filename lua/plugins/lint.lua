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

-- Auto-lint only on save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback = function()
        pcall(require('lint').try_lint)
    end,
})

