local M = {}

function M.setup()
  require("mini.pairs").setup()
  require("mini.icons").setup()

  vim.keymap.set("n", "<C-x>", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "Close buffer" })
end

return M
