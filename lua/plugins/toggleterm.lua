return {
  'akinsho/toggleterm.nvim',
  event = "VeryLazy",
  version = "*",
  config = function()
    vim.api.nvim_set_hl(0, "ToggleTermBG", { bg = "#171f2b" })

    require("toggleterm").setup({
      open_mapping = [[<C-`>]],
      on_open = function(term)
        vim.wo[term.window].winhighlight = "Normal:ToggleTermBG"
      end,
      direction = 'float',
    })
  end
}
