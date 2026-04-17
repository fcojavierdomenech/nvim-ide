-- Colorscheme configuration (converted from colorscheme.vimrc)

-- Custom highlight modifications
local function set_highlights()
    -- Clear and set fold highlights
    vim.cmd('hi clear FoldColumn')
    vim.cmd('hi clear Folded')
    vim.cmd('hi Folded ctermfg=216 ctermbg=none')
    vim.cmd('hi FoldColumn ctermfg=216 ctermbg=None')
    
    -- Popup menu
    vim.cmd('hi Pmenu ctermbg=NONE ctermfg=blue')
    
    -- Cursor line
    vim.cmd('hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white')
    
    -- Line numbers
    vim.cmd('hi LineNr ctermfg=red ctermbg=none')
    
    -- Matching parentheses
    vim.cmd('hi MatchParen cterm=bold ctermbg=black ctermfg=magenta')
    
    -- Search highlights
    vim.cmd('hi ObliqueCurrentMatch cterm=bold ctermbg=white ctermfg=black')
    
    -- Sneak plugin
    vim.cmd('hi Sneak ctermbg=blue')
    
    -- Normal background
    vim.cmd('highlight Normal ctermfg=NONE ctermbg=NONE')
    
    -- Italic comments
    vim.cmd('set t_ZH=\27[3m')
    vim.cmd('set t_ZR=\27[23m')
    vim.cmd('highlight Comment ctermfg=grey cterm=italic')
    
    -- Error highlights
    vim.cmd('hi Error ctermfg=17 ctermbg=166 cterm=none')
    vim.cmd('hi SpellBad ctermfg=17 ctermbg=166 cterm=undercurl')
end

-- PHP syntax overrides
local function php_syntax_override()
    vim.cmd('hi! phpTodo ctermfg=120')
    vim.cmd('hi! phpDocTags ctermfg=241')
    vim.cmd('hi! phpDocParam ctermfg=243')
end

-- CoC completion overrides
local function coc_override()
    vim.cmd('hi Pmenu ctermbg=24')
    vim.cmd('hi CocSearch ctermfg=11')
    vim.cmd('hi FgCocErrorFloatBgCocFloating ctermbg=24 ctermfg=Red')
    vim.cmd('hi CocMenuSel ctermfg=blue ctermbg=150')
    vim.cmd('hi PmenuSbar guibg=#bcbcbc')
    vim.cmd('hi PmenuThumb guibg=#585858')
end

-- Braces coloring autocmd
local augroup = vim.api.nvim_create_augroup('ColorScheme', { clear = true })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = augroup,
    pattern = '*',
    callback = function()
        vim.cmd('syn match parens /[(){}]/ | hi parens ctermfg=223')
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'php',
    callback = php_syntax_override,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    group = augroup,
    pattern = '*',
    callback = coc_override,
})

-- Function to check highlight group
local function check_hi_group()
    if not vim.fn.exists('*synstack') then
        return
    end
    local synstack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
    local names = {}
    for _, id in ipairs(synstack) do
        table.insert(names, vim.fn.synIDattr(id, 'name'))
    end
    print(vim.inspect(names))
end

-- Create command for highlight checking
vim.api.nvim_create_user_command('CheckHiGroup', check_hi_group, {})

-- Apply highlights on startup
set_highlights()

-- Set diff options
vim.opt.diffopt:append('vertical')

