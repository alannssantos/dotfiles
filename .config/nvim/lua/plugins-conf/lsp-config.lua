-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

-- npm i -g bash-language-server
require'lspconfig'.bashls.setup{ }

-- npm i -g pyright
require'lspconfig'.pyright.setup{ }
