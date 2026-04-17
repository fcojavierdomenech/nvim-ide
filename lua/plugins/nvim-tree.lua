-- Nvim-tree configuration

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings
  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
end

require('nvim-tree').setup({
  on_attach = on_attach,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
    sort_by = 'name',
    view = {
        width = 35,
        side = 'left',  -- Place nvim-tree on the left (avante on the right)
    },
    renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          glyphs = {
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
    },
    git = {
      enable = true,
      ignore = false,
    },
    -- Respect other windows (like avante sidebar)
    actions = {
      open_file = {
        resize_window = false,  -- Don't auto-resize to avoid conflicts with avante
      },
    },
})

vim.keymap.set('n', '<leader>E', function() vim.cmd(':NvimTreeFindFile') end, { desc = 'Toggle File Explorer on current file' })

-- Keymap
vim.keymap.set('n', '<leader>e', function() vim.cmd(':NvimTreeToggle') end, { desc = 'Toggle File Explorer' })