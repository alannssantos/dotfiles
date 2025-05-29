return {
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
}
