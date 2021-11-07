require'which-key'.setup()

require'which-key'.register({
  ["jk"] = { "<Esc>", "Normal mode", mode = "i" },
  ["kj"] = { "<Esc>", "Normal mode", mode = "i" },
  ["<Tab>"] = { "<cmd>tabn<CR>", "Próxima Guia" },
  ["<leader>q"] = { "<cmd>q<CR>", "Fechar Guia" },
  ["<leader>e"] = { "<cmd>Explore<CR>", "Explorer" },
  ["<leader>/"] = { "<cmd>CommentToggle<CR>", "Comentar" },
  ["<leader>w"] = { "<cmd>SudaWrite<CR>", "Salvar com Sudo" },
  ["<leader>f"] = { "<cmd>FzfLua files<cr>", "Procurar Arquivo" },
  ["<leader>p"] = { "<cmd>Glow<CR>", "Pré-visualizarão Markdown" },
  ["<leader>o"] = { "<cmd>set spell!<CR>", "Corretor Ortográfico" },
  ["<leader>n"] = { "<cmd>%!nl -n rz -w3<CR>", "Numerador de Linhas" },
  ["<leader>s"] = { "<cmd>!clear && shellcheck -x %<CR>", "ShellCheck" },
  ["<leader>t"] = { "<cmd>tab sball<CR>", "Transformar buffers em tabs" },
  ["<leader>c"] = { "<cmd>set operatorfunc=CommentOperator<CR>g@", "Comentar", mode = "v" },
})
