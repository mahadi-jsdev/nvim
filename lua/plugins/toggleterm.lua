local M = {}

function M.setup()
  require("toggleterm").setup({
    size = 20,
    open_mapping = [[<C-t>]],
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
  })

  vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
end

return M
