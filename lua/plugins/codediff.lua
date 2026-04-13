local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>cd", "<cmd>CodeDiff<cr>", { desc = "CodeDiff" })
end

return M
