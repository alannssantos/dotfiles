return {
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
}
