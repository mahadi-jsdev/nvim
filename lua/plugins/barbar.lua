local M = {}

function M.setup()
  require("barbar").setup({})

  local map = vim.keymap.set
  -- Buffers
  map("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })
  map("n", "<C-x>", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
  map("n", "<C-h>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
  map("n", "<C-l>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
  map("n", "<C-Left>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
  map("n", "<C-Right>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
  map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Go to buffer 1" })
  map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Go to buffer 2" })
  map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Go to buffer 3" })
  map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Go to buffer 4" })
  map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Go to buffer 5" })
  map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Go to buffer 6" })
  map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Go to buffer 7" })
  map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Go to buffer 8" })
  map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Go to buffer 9" })
end

return M
