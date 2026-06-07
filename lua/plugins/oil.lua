local M = {}

function M.setup()
  require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-s>"] = false,
      ["<C-v>"] = false,
      ["<C-x>"] = false,
    },
  })

  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return M
