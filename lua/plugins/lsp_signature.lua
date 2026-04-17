{
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
        bind = true,
        handler_opts = {
            border = "rounded",
        },
        floating_window = true,
        close_timeout = 0, -- 👈 Keeps it open until you press Esc/CR
        hint_enable = false,
    },
}
