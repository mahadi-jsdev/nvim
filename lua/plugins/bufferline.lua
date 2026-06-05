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

  -- actions
  map("n", "<leader>bs", "<CMD>BufferLineSortByRelativeDirectory<CR>", { desc = "Relative" })
  map("n", "<leader>bp", "<CMD>BufferLineTogglePin<CR>")
  map("n", "<leader>bcr", "<CMD>BufferLineCloseRight<CR>")
  map("n", "<leader>bcl", "<CMD>BufferLineCloseLeft<CR>")
  map("n", "<leader>bco", "<CMD>BufferLineCloseOthers<CR>")
end

return M
