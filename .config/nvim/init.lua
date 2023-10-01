--      _    _
--     / \  | | __ _ _ __  _ __      Alann Santos
--    / _ \ | |/ _` | '_ \| '_ \     https://github.com/alannssantos
--   / ___ \| | (_| | | | | | | |
--  /_/   \_\_|\__,_|_| |_|_| |_|

vim.g.mapleader         = ' '

if vim.fn.has('termguicolors') == 1 then
    vim.g.termguicolors = true
end

vim.opt.title           = true
vim.opt.hidden          = true
vim.opt.spell           = false
vim.opt.number          = true
vim.opt.confirm         = true
vim.opt.hlsearch        = true
vim.opt.wildmenu        = true
vim.opt.expandtab       = true
vim.opt.incsearch       = true
vim.opt.path            = '+=**'
vim.opt.splitbelow      = true
vim.opt.splitright      = true
vim.opt.smartindent     = true
vim.opt.spelllang       = 'pt'
vim.opt.laststatus      = 2
vim.opt.shiftwidth      = 2
vim.opt.showtabline     = 2
vim.opt.softtabstop     = 2
vim.opt.foldmethod      = 'marker'
vim.opt.clipboard       = 'unnamedplus'
vim.opt.guifont         = 'Fira Code:h12'

-- mapping
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("n", "<Tab>", ":bNext<CR>")
vim.keymap.set('n', '<leader>e', ':Texplore<CR>')
vim.keymap.set('n', '<leader>n', ':%!nl -n rz -w3<CR>')
vim.keymap.set('n', '<leader>o', ':set spell! spelllang=pt<CR>')
vim.keymap.set('n', '<leader>s', ':!clear && shellcheck -x %<CR>')

-- netrw: config
vim.g['netrw_altv']         = '1'
vim.g['netrw_winsize']      = '25'
vim.g['netrw_liststyle']    = '3'
vim.g['netrw_browse_split'] = '3'

require("lazy-plugin")
