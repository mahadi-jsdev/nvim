return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  config = function()
    require("ibl").setup {
      scope = { enabled = false },
    }
  end
}
