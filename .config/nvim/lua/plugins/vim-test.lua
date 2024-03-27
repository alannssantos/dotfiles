return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  vim.keymap.set('n', '<leader>T', ':TestNearest<CR>'),
  vim.keymap.set('n', '<leader>t', ':TestFile<CR>'),
  vim.keymap.set('n', '<leader>a', ':TestSuite<CR>'),
  vim.keymap.set('n', '<leader>l', ':TestLast<CR>'),
  vim.keymap.set('n', '<leader>g', ':TestVisit<CR>'),
  vim.cmd("let test#strategy = 'vimux'")
}
