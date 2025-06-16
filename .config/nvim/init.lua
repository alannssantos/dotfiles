--      _    _
--     / \  | | __ _ _ __  _ __      Alann Santos
--    / _ \ | |/ _` | '_ \| '_ \     https://github.com/alannssantos
--   / ___ \| | (_| | | | | | | |
--  /_/   \_\_|\__,_|_| |_|_| |_|

vim.g.mapleader = " "

if vim.fn.has("termguicolors") == 1 then
	vim.g.termguicolors = true
end

vim.opt.list = true
vim.opt.tabstop = 2
vim.opt.title = true
vim.opt.spell = false
vim.opt.hidden = true
vim.opt.number = true
vim.opt.path = "+=**"
vim.opt.confirm = true
vim.opt.scrolloff = 10
vim.opt.laststatus = 2
vim.opt.shiftwidth = 2
vim.opt.hlsearch = true
vim.opt.wildmenu = true
vim.opt.showtabline = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.spelllang = "pt"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.colorcolumn = "80"
vim.opt.smartindent = true
vim.opt.foldmethod = "marker"
vim.opt.relativenumber = true
vim.opt.guifont = "Fira Code:h11"
vim.opt.clipboard = "unnamedplus"
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- mapping
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")
vim.keymap.set("t", "kj", "<C-\\><C-n>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<Tab>", ":bNext<CR>", {})
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>")
vim.keymap.set("n", "<leader><Tab>", ":tabNext<CR>", {})
vim.keymap.set("n", "<leader>t", ":terminal ", {})
vim.keymap.set("n", "<leader>n", ":%!nl -n rz -w3<CR>", {})
vim.keymap.set("n", "<leader>o", ":set spell! spelllang=pt<CR>", {})
vim.keymap.set("n", "<leader>q", ":bwipe<CR>", { desc = "Fechar Buffer" })

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
