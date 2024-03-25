return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",        -- source for text in buffer
      "hrsh7th/cmp-path",          -- source for file system paths
      "L3MON4D3/LuaSnip",          -- snippet engine
      "saadparwaiz1/cmp_luasnip",  -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "f3fora/cmp-spell",          -- spellcheck
      "onsails/lspkind.nvim",      -- vs-code like pictograms
    },
    config = function()
      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("cmp").setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = require("cmp").config.window.bordered(),
          documentation = require("cmp").config.window.bordered(),
        },
        mapping = require("cmp").mapping.preset.insert({
          ["<C-k>"] = require("cmp").mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = require("cmp").mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
          ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
          ["<C-Space>"] = require("cmp").mapping.complete(), -- show completion suggestions
          ["<C-e>"] = require("cmp").mapping.abort(),   -- close completion window
          ["<CR>"] = require("cmp").mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = require("cmp").config.sources({
          { name = "spell" }, -- spellcheck
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = require("lspkind").cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },
}
