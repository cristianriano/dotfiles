return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = LazyVim.root(), hidden = true })
      end,
      desc = "Explorer Snacks (root dir)",
    },
  },
}