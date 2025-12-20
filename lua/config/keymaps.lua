local map = vim.keymap.set

-- Keymps (Basic)
map({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>")
map("n", "<ESC>", ":nohlsearch<CR>")
map("n", "<C-v>", ":leftabove vsplit<CR>")
map("n", "<leader>qq", ":q<CR>")
map("n", "zz", "za")

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- QuickFix
map("n", "<M-o>", ":copen<CR>", { desc = "Open quickfix" })
map("n", "<M-x>", ":cclose<CR>", { desc = "close quickfix" })
map("n", "<M-k>", ":cprev<CR>", { desc = "previous quickfix" })
map("n", "<M-j>", ":cnext<CR>", { desc = "next quickfix" })

-- resize window
map("n", "=", [[<cmd>vertical resize +5<cr>]])

-- cycle between buffer
map("n", "<C-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<C-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- move lines
map("n", "<M-u>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-d>", ":m .+1<CR>==", { desc = "Move line down" })
map("v", "<M-u>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<M-d>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
