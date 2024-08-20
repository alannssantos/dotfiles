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
			"nvim-tree/nvim-web-devicons", -- If you want devicons
			"stevearc/resession.nvim", -- Optional, for persistent history
		},
		config = function()
			local get_hex = require("cokeline.hlgroups").get_hl_attr

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
	-- indent-blankline.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end,
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
	-- telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").setup({})
			-- set keymaps
			vim.keymap.set(
				"n",
				"<leader>ff",
				require("telescope.builtin").find_files,
				{ desc = "Fuzzy find files in cwd" }
			)
			vim.keymap.set(
				"n",
				"<leader>fr",
				require("telescope.builtin").oldfiles,
				{ desc = "Fuzzy find recent files" }
			)
			vim.keymap.set("n", "<leader>fs", require("telescope.builtin").live_grep, { desc = "Find string in cwd" })
			vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find buffers" })
			vim.keymap.set(
				"n",
				"<leader>fc",
				require("telescope.builtin").grep_string,
				{ desc = "Find string under cursor in cwd" }
			)
		end,
	},
	-- numToStr/Comment.nvim
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>c",
				},
				opleader = {
					line = "<leader>c",
				},
			})
		end,
	},
	-- Formatter
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
				local lsp_zero = require("lsp-zero")

				local lsp_attach = function(client, bufnr)
					local opts = { buffer = bufnr }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
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
