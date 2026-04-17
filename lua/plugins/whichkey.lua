return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    { "echasnovski/mini.icons" },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- No need to explicitly set hidden, ignore_missing, popup_mappings, window
    -- as these are deprecated and their new equivalents are implicitly handled or have new names.
    -- If you had specific configurations for these, you would re-map them to their new equivalents (e.g., opts.filter, opts.keys, opts.win).
    -- For now, we'll keep the basic structure.
  },
}
