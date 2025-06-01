return {
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
					virtual_text = { prefix = "●" },
					severity_sort = true,
					float = {
						source = "always", -- Or "if_many"
						border = "single",
					},
				})

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
}
