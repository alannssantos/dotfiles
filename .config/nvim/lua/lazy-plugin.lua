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
				vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
				vim.g.neovide_opacity = 0.96
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
			require("mini.pick").setup()
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
				mappings = {
					go_in = "L",
					go_in_plus = "l", -- open file & close filetree
				},
			})
			require("mini.clue").setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					require("mini.clue").gen_clues.builtin_completion(),
					require("mini.clue").gen_clues.g(),
					require("mini.clue").gen_clues.marks(),
					require("mini.clue").gen_clues.registers(),
					require("mini.clue").gen_clues.windows(),
					require("mini.clue").gen_clues.z(),
				},
			})
			vim.keymap.set("n", "<leader>fr", ":Pick oldfiles<CR>", { desc = "Arquivos recentes" })
			vim.keymap.set("n", "<leader>fd", ":Pick diagnostic<CR>", { desc = "Diagnosticos LSP" })
			vim.keymap.set("n", "<leader>ff", ":Pick explorer<CR>", { desc = "Pesquisador de Arquivos" })
			vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Navegador de Arquivos" })
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
				local lsp_attach = function(client, bufnr)
					local opts = { buffer = bufnr }
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
				end

				vim.diagnostic.config({
					virtual_text = {
						prefix = "●", -- Could be '■', '▎', 'x'
					},
					severity_sort = true,
					float = {
						source = "always", -- Or "if_many"
					},
				})
				local signs = { Error = "●", Warn = "●", Hint = "●", Info = "●" }
				for type, icon in pairs(signs) do
					local hl = "DiagnosticSign" .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end

				local lsp_zero = require("lsp-zero")
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
