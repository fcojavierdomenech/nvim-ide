local grug_far = require('grug-far')

grug_far.setup({
  -- You can add custom configuration here if needed
  -- For example, to change the default keymaps
  keymaps = {
    replace = { n = '<leader>R' },
    qflist = { n = '<leader>q' },
    syncLocations = { n = '<leader>s' },
    syncLine = { n = '<leader>l' },
    close = { n = '<leader>c' },
    historyOpen = { n = '<leader>t' },
    historyAdd = { n = '<leader>a' },
    refresh = { n = '<leader>f' },
    openLocation = { n = '<leader>o' },
    gotoLocation = { n = '<leader>G' },
    pickSerializer = { n = '<leader>p' },
    toggleMode = { n = '<leader>m' },
    showHelp = { n = '?' },
  },
})

-- Keymap to open grug-far
-- Changed to <leader>sr as requested to avoid conflicts with refactoring (<leader>r)
vim.keymap.set('n', '<leader>sr', function()
  grug_far.open({
    transient = true,
    prefills = {
      search = vim.fn.expand('<cword>'),
    },
  })
end, { desc = 'Grug-far: Search and Replace' })
