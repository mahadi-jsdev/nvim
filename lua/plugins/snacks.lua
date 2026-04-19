local M = {}

function M.setup()
  require("snacks").setup({
    picker = {},
    statuscolumn = {},
    scope = {},
    input = {},
    notifier = {},
    indent = {},
    explorer = {},
    dashboard = {},
  })

  vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
  end, { desc = "explorer" })
end

return M
