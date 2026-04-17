-- LuaSnip configuration

local luasnip = require('luasnip')

-- Load snippets from VSCode-style packages
require('luasnip.loaders.from_vscode').lazy_load()

-- Key mappings
vim.keymap.set({'i', 's'}, '<C-l>', function()
    if require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
    end
end, { silent = true, desc = 'Expand or Jump' })

vim.keymap.set({'i', 's'}, '<C-j>', function()
    if require('luasnip').jumpable(1) then
        require('luasnip').jump(1)
    end
end, { silent = true, desc = 'Jump Forward' })

vim.keymap.set({'i', 's'}, '<C-k>', function()
    if require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
    end
end, { silent = true, desc = 'Jump Backward' })

vim.keymap.set('i', '<C-e>', function()
    if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
    end
end, { desc = 'Change Choice' })

