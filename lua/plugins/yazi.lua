local M = {}

function M.setup()
  require("yazi").setup({
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
  })

  vim.keymap.set("n", "-", "<CMD>Yazi<CR>", { desc = "Open yazi at current file" })
end

return M
