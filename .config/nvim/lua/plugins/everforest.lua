return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("everforest").setup({
      transparent_background_level = 1,
    })
    require("everforest").load()

    -- This section is for transparency in neovide.
    if vim.g.neovide then
      vim.g.neovide_transparency     = 0.96
      require("everforest").setup({
        transparent_background_level = 0,
      })
      require("everforest").load()
    end
  end,
}
