local map = vim.keymap.set

local function notify_copy(message)
  vim.schedule(function()
    vim.notify(message, vim.log.levels.INFO, { title = "Clipboard" })
  end)
end

-- Keymps (Basic)
map({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>")
map("n", "<ESC>", "<CMD>nohlsearch<CR>")
map("n", "<leader>qq", "<CMD>q<CR>")
map("n", "zz", "za")

-- NvChad UI
map({ "n", "t" }, "<c-t>", function()
  require("nvchad.term").toggle({ pos = "bo sp", id = "hTerm" })
end, { desc = "Toggle horizontal terminal" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- QuickFix
map("n", "<M-o>", "<CMD>copen<CR>", { desc = "Open quickfix" })
map("n", "<M-x>", "<CMD>cclose<CR>", { desc = "close quickfix" })
map("n", "<M-k>", "<CMD>cprev<CR>", { desc = "previous quickfix" })
map("n", "<M-j>", "<CMD>cnext<CR>", { desc = "next quickfix" })

-- move lines
map("n", "<M-u>", "<CMD>m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-d>", "<CMD>m .+1<CR>==", { desc = "Move line down" })
map("v", "<M-u>", "<CMD>m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<M-d>", "<CMD>m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Copy relative path to clipboard
vim.keymap.set("n", "<leader>cf", function()
  local relative_path = vim.fn.expand("%:.") -- Get path relative to cwd
  vim.fn.setreg("+", relative_path)          -- Write to system clipboard register
  notify_copy("Copied relative path: " .. relative_path)
end, { desc = "Copy relative file path to clipboard" })
