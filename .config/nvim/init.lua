--      _    _
--     / \  | | __ _ _ __  _ __      Alann Santos
--    / _ \ | |/ _` | '_ \| '_ \     https://github.com/alannssantos
--   / ___ \| | (_| | | | | | | |
--  /_/   \_\_|\__,_|_| |_|_| |_|

vim.g.mapleader = " "

if vim.fn.has("termguicolors") == 1 then
	vim.g.termguicolors = true
end

-- basics settings
local set = vim.opt
set.list = true
set.tabstop = 2
set.title = true
set.spell = false
set.hidden = true
set.number = true
set.path = "+=**"
set.confirm = true
set.scrolloff = 10
set.laststatus = 2
set.shiftwidth = 2
set.hlsearch = true
set.wildmenu = true
set.showtabline = 2
set.softtabstop = 2
set.expandtab = true
set.incsearch = true
set.spelllang = "pt"
set.splitbelow = true
set.splitright = true
set.colorcolumn = "80"
set.smartindent = true
set.winborder = "rounded"
set.foldmethod = "marker"
set.relativenumber = true
set.guifont = "Fira Code:h11"
set.clipboard = "unnamedplus"
set.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- mapping
local map = vim.keymap
map.set("i", "jk", "<Esc>")
map.set("i", "kj", "<Esc>")
map.set("t", "jk", "<C-\\><C-n>")
map.set("t", "kj", "<C-\\><C-n>")
map.set("t", "<Esc>", "<C-\\><C-n>")
map.set("n", "<Tab>", ":bNext<CR>", {})
map.set("n", "<leader>e", ":Lexplore<CR>")
map.set("n", "<leader><Tab>", ":tabNext<CR>", {})
map.set("n", "<leader>t", ":terminal ", {})
map.set("n", "<leader>n", ":%!nl -n rz -w3<CR>", {})
map.set("n", "<leader>o", ":set spell! spelllang=pt<CR>", {})
map.set("n", "<leader>q", ":bwipe<CR>", { desc = "Fechar Buffer" })

-- blink on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- netrw: config
vim.g["netrw_altv"] = "1"
vim.g["netrw_winsize"] = "25"
vim.g["netrw_liststyle"] = "3"
vim.g["netrw_browse_split"] = "3"
vim.g["netrw_list_hide"] = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.api.nvim_create_autocmd("filetype", {
	pattern = "netrw",
	desc = "Better mappings for netrw",
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end
		-- open file
		bind("l", "<CR>")
		-- edit new file
		bind("f", "%")
		-- rename file
		bind("r", "R")
	end,
})

require("lazy-pkg")
