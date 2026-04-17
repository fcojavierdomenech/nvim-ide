-- Airline configuration

vim.g.airline_theme = 'bubblegum'
vim.g['airline#extensions#syntastic#enabled'] = 1
vim.g['airline#extensions#branch#enabled'] = 1
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#whitespace#mixed_indent_algo'] = 1
vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
vim.g.airline_section_x = '%{fnamemodify(getcwd(),":t")}'
vim.g['airline#extensions#tagbar#flags'] = 'f'
vim.opt.ttimeoutlen = 50
vim.opt.laststatus = 2

-- Airline symbols
if not vim.g.airline_symbols then
    vim.g.airline_symbols = {}
end

