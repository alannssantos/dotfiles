return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  config = function()
    vim.fn["mkdp#util#install"]()
    vim.keymap.set("n", "gm", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
  end,
}
