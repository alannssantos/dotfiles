-- AutoInstall do Lazy.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Aqui começa os plugins!
require("lazy").setup({
	-- everforest-nvim
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				transparent_background_level = 1,
			})
			require("everforest").load()

			-- Esta parte é para aplicar transparência no neovide.
			if vim.g.neovide then
				vim.g.neovide_transparency = 0.96
				require("everforest").setup({
					transparent_background_level = 0,
				})
				require("everforest").load()
			end
		end,
	},
	-- nvim-cokeline
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"stevearc/resession.nvim", -- Optional, for persistent history
		},
		config = function()
			require("cokeline").setup({
				components = {
					{
						text = function(buffer)
							if buffer.is_modified then
								return " + " .. buffer.filename .. " "
							end
							return " " .. buffer.filename .. " "
						end,
						bold = function(buffer)
							return buffer.is_focused
						end,
					},
				},
			})
		end,
	},
	-- nvim-colorizer
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	-- mini.nvim
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.extra").setup()
			require("mini.pairs").setup()
			require("mini.statusline").setup()
			require("mini.indentscope").setup()
			require("mini.comment").setup({
				mappings = {
					comment_line = "<leader>c",
					comment_visual = "<leader>c",
				},
			})
			require("mini.files").setup({
				windows = {
					preview = true,
					width_focus = 30,
					width_preview = 60,
				},
			})
			require("mini.pick").setup()
			vim.keymap.set("n", "<leader>ff", ":Pick explorer<CR>")
			vim.keymap.set("n", "<leader>fr", ":Pick oldfiles<CR>")
			vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>")
		end,
	},
	-- render markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	-- which-key.nvim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
	},
	-- stevearc/conform.nvim
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					bash = { "shfmt" },
					yaml = { "yamlfmt" },
					python = { "isort", "black" },
				},
			})
		end,
	},
	-- folke/trouble.nvim
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>d",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
	},
	-- LSP Configuração
	{
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v4.x",
			lazy = true,
			config = false,
		},
		{
			"williamboman/mason.nvim",
			lazy = false,
			config = true,
		},

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

		-- LSP
		{
			"neovim/nvim-lspconfig",
			cmd = { "LspInfo", "LspInstall", "LspStart" },
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },
			},
			config = function()
				local lsp_zero = require("lsp-zero")

				local lsp_attach = function(client, bufnr)
					local opts = { buffer = bufnr }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				end

				lsp_zero.extend_lspconfig({
					sign_text = true,
					lsp_attach = lsp_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				})

				require("mason-lspconfig").setup({
					ensure_installed = {},
					handlers = {
						function(server_name)
							require("lspconfig")[server_name].setup({})
						end,
					},
				})
			end,
		},
	},
})
