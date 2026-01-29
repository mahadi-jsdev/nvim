local map = vim.keymap.set

-- Keymps (Basic)
map({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>")
map("n", "<ESC>", "<CMD>nohlsearch<CR>")
map("n", "<C-v>", "<CMD>leftabove vsplit<CR>")
map("n", "<leader>qq", "<CMD>q<CR>")
map("n", "zz", "za")

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- QuickFix
map("n", "<M-o>", "<CMD>copen<CR>", { desc = "Open quickfix" })
map("n", "<M-x>", "<CMD>cclose<CR>", { desc = "close quickfix" })
map("n", "<M-k>", "<CMD>cprev<CR>", { desc = "previous quickfix" })
map("n", "<M-j>", "<CMD>cnext<CR>", { desc = "next quickfix" })

-- resize window
map("n", "=", [[<CMD>vertical resize +5<CR>]])

-- cycle between buffer
map("n", "<C-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })
map("n", "<C-h>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<C-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })
map("n", "<C-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

-- move lines
map("n", "<M-u>", "<CMD>m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-d>", "<CMD>m .+1<CR>==", { desc = "Move line down" })
map("v", "<M-u>", "<CMD>m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<M-d>", "<CMD>m '>+1<CR>gv=gv", { desc = "Move selection down" })
