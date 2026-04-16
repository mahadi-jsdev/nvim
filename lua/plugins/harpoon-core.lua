local M = {}

function M.setup()
  local ok, harpoon = pcall(require, "harpoon-core")
  if not ok then
    return
  end

  harpoon.setup({})

  local map = vim.keymap.set

  -- harpoon core
  map("n", "<leader>ml", ":lua require('harpoon-core').toggle_quick_menu()<CR>", { desc = "harpoon view" })
  map("n", "<leader>ma", ":lua require('harpoon-core').add_file()<CR>", { desc = "harpoon add" })
  map("n", "<leader>mr", ":lua require('harpoon-core').rm_file()<CR>", { desc = "harpoon add" })
  map("n", "<C-l>", ":lua require('harpoon-core').nav_next()<CR>", { desc = "harpoon next" })
  map("n", "<C-h>", ":lua require('harpoon-core').nav_prev()<CR>", { desc = "harpoon prev" })

  -- number based navigation
  map("n", "<A-1>", ":lua require('harpoon-core').nav_file(1)<CR>", { desc = "harpoon 1" })
  map("n", "<A-2>", ":lua require('harpoon-core').nav_file(2)<CR>", { desc = "harpoon 2" })
  map("n", "<A-3>", ":lua require('harpoon-core').nav_file(3)<CR>", { desc = "harpoon 3" })
  map("n", "<A-4>", ":lua require('harpoon-core').nav_file(4)<CR>", { desc = "harpoon 4" })
  map("n", "<A-5>", ":lua require('harpoon-core').nav_file(5)<CR>", { desc = "harpoon 5" })
end

return M
