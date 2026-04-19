local M = {}

function M.setup()
  local ok, kulala = pcall(require, "kulala")
  if not ok then
    return
  end

  kulala.setup({
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
    lsp = {
      enable = false,
    },
  })
end

return M
