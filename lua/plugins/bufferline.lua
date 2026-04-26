local M = {}

function M.setup()
  local bufferline = require('bufferline')
  bufferline.setup {
    options = {
      diagnostics = "nvim_lsp"
    }
  }

  local map = vim.keymap.set

  map("n", "<C-l>", "<CMD>BufferLineCycleNext<CR>", { desc = "Next buffer" })
  map("n", "<C-h>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
  map("n", "<C-Right>", "<CMD>BufferLineMoveNext<CR>", { desc = "Move Next buffer" })
  map("n", "<C-Left>", "<CMD>BufferLineMovePrev<CR>", { desc = "Previous buffer" })
  map("n", "<C-p>", "<CMD>BufferLinePick<CR>", { desc = "BufferPick" })

  -- actions
  map("n", "<leader>bsr", "<CMD>BufferLineSortByRelativeDirectory<CR>", { desc = "Relative" })
  map("n", "<leader>bp", "<CMD>BufferLineTogglePin<CR>")
  map("n", "<leader>bcr", "<CMD>BufferLineCloseRight<CR>")
  map("n", "<leader>bcl", "<CMD>BufferLineCloseLeft<CR>")
  map("n", "<leader>bco", "<CMD>BufferLineCloseOthers<CR>")

  -- go to
  map("n", "<leader>1", "<CMD>BufferLineGoToBuffer 1<CR>", { desc = "go to" })
  map("n", "<leader>2", "<CMD>BufferLineGoToBuffer 2<CR>", { desc = "go to" })
  map("n", "<leader>3", "<CMD>BufferLineGoToBuffer 3<CR>", { desc = "go to" })
  map("n", "<leader>4", "<CMD>BufferLineGoToBuffer 4<CR>", { desc = "go to" })
  map("n", "<leader>5", "<CMD>BufferLineGoToBuffer 5<CR>", { desc = "go to" })
  map("n", "<leader>6", "<CMD>BufferLineGoToBuffer 6<CR>", { desc = "go to" })
  map("n", "<leader>7", "<CMD>BufferLineGoToBuffer 7<CR>", { desc = "go to" })
  map("n", "<leader>8", "<CMD>BufferLineGoToBuffer 8<CR>", { desc = "go to" })
  map("n", "<leader>9", "<CMD>BufferLineGoToBuffer 9<CR>", { desc = "go to" })
end

return M
