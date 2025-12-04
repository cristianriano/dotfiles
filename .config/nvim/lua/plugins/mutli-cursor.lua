return {
  "mg979/vim-visual-multi",
  -- To make multi cursors visible in TokyoNight
  -- Source: https://github.com/mg979/vim-visual-multi/issues/259#issuecomment-2989379983
  config = function()
    local incsearch_hl = vim.api.nvim_get_hl(0, { name = "IncSearch" })

    vim.api.nvim_set_hl(0, "VMCustom", {
      fg = incsearch_hl.fg, -- black fg text from IncSearch (adapts to colorschemes)
      bg = "#ff59f4", -- bright pink background that contrasts well with tokyonight IncSearch's orange
    })

    vim.api.nvim_set_hl(0, "VM_Extend", { link = "VMCustom" })
    vim.api.nvim_set_hl(0, "VM_Insert", { link = "VMCustom" })
    vim.api.nvim_set_hl(0, "VM_Cursor", { link = "VMCustom" })
    vim.api.nvim_set_hl(0, "VM_Mono", { link = "VMCustom" })
  end,
}