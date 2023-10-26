return {
  {'akinsho/toggleterm.nvim',
      version = "*",
      opts = {
        vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=float<cr>')
      }
  }
}
