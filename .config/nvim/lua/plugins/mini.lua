return {
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
}
