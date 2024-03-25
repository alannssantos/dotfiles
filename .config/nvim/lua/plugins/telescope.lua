return {
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
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Fuzzy find files in cwd" })
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = "Fuzzy find recent files" })
      vim.keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep, { desc = "Find string in cwd" })
      vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find buffers" })
      vim.keymap.set('n', '<leader>fc', require('telescope.builtin').grep_string, { desc = "Find string under cursor in cwd" })
    end,
  },
}
