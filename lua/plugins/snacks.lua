local M = {}

function M.setup()
  require("snacks").setup({
    picker = {},
    statuscolumn = {},
    scope = {},
    input = {},
    notifier = {},
    indent = {},
    -- dashboard = {},
  })
end

return M
