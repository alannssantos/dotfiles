return {
  {'akinsho/toggleterm.nvim',
      version = "*",
      opts = {
        vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>')
      }
  }
}
