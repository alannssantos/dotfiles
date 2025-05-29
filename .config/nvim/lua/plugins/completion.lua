return {
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"f3fora/cmp-spell", -- spellcheck
			"hrsh7th/cmp-path", -- source for file system paths
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				window = {
					completion = require("cmp").config.window.bordered(),
					documentation = require("cmp").config.window.bordered(),
				},
				sources = {
					{ name = "spell" }, -- spellcheck
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- snippets
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = require("cmp").mapping.select_next_item(), -- next suggestion
					["<S-Tab>"] = require("cmp").mapping.select_prev_item(), -- previous suggestion
					["<C-k>"] = require("cmp").mapping.scroll_docs(-4),
					["<C-j>"] = require("cmp").mapping.scroll_docs(4),
					["<C-s>"] = require("cmp").mapping.complete(), -- show completion suggestions
					["<C-c>"] = require("cmp").mapping.abort(), -- close completion window
					["<CR>"] = require("cmp").mapping.confirm({ select = false }),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
			})
		end,
	},
}
