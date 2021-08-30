require'which-key'.setup()

require'which-key'.register({
  ["<Tab>"] = { "<cmd>bn<CR>", "Fechar Guia" },
  ["<leader>q"] = { "<cmd>bw<CR>", "Fechar Guia" },
  ["<leader>/"] = { "<cmd>CommentToggle<CR>", "Comentar" },
  ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  ["<leader>f"] = { "<cmd>FzfLua files<cr>", "Procurar Arquivo" },
  ["<leader>o"] = { "<cmd>set spell!<CR>", "Corretor Ortográfico" },
  ["<leader>n"] = { "<cmd>%!nl -n rz -w3<CR>", "Numerador de Linhas" },
  ["<leader>s"] = { "<cmd>!clear && shellcheck -x %<CR>", "ShellCheck" },
})

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {})
vim.api.nvim_set_keymap('', '<leader>/', '<cmd>set operatorfunc=CommentOperator<CR>g@', {})
