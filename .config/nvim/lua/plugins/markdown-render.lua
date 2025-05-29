return {
	-- render markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = {
				backgrounds = {
					"Headline1Bg",
					"Headline2Bg",
					"Headline3Bg",
					"Headline4Bg",
					"Headline5Bg",
					"Headline6Bg",
				},
			},
		},
	},
}
