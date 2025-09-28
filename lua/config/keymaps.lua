local map = vim.keymap.set

-- Keymps (Basic)
map({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>")
map("n", "<ESC>", "<CMD>nohlsearch<CR>")
map("n", "<C-v>", "<CMD>leftabove vsplit<CR>")
map("n", "<leader>qq", "<CMD>q<CR>")

-- autopairs
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", '"', '""<Left>')
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", "`", "``<Left>")

-- QuickFix
map("n", "<M-o>", "<CMD>copen<CR>", { desc = "Open quickfix" })
map("n", "<M-x>", "<CMD>cclose<CR>", { desc = "close quickfix" })
map("n", "<M-k>", "<CMD>cprev<CR>", { desc = "previous quickfix" })
map("n", "<M-j>", "<CMD>cnext<CR>", { desc = "next quickfix" })

-- resize window
map("n", "=", [[<cmd>vertical resize +5<cr>]])
-- Key("n", "-", [[<cmd>vertical resize -5<cr>]])

-- cycle between buffer
map("n", "<C-Right>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<C-Left>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<C-x>", ":bd<CR>", { desc = "delete buffer" })

-- move lines
map("n", "<M-u>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-d>", ":m .+1<CR>==", { desc = "Move line down" })
map("v", "<M-u>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<M-d>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
