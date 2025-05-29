return {
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
}
