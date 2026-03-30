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
-- map("n", "<C-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })
-- map("n", "<C-h>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
-- map("n", "<C-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })
-- map("n", "<C-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

-- move lines
map("n", "<M-u>", "<CMD>m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-d>", "<CMD>m .+1<CR>==", { desc = "Move line down" })
map("v", "<M-u>", "<CMD>m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<M-d>", "<CMD>m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Copy relative path to clipboard
vim.keymap.set("n", "<leader>cf", function()
  local relative_path = vim.fn.expand("%:.")       -- Get path relative to cwd
  vim.fn.setreg("+", relative_path)                -- Write to system clipboard register
  print("Copied relative path: " .. relative_path) -- Confirmation message
end, { desc = "Copy relative file path to clipboard" })


local function get_visual_range()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  return start_line, start_col, end_line, end_col
end

local function get_visual_text()
  local start_line, start_col, end_line, end_col = get_visual_range()
  local lines = vim.api.nvim_buf_get_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, {})

  return table.concat(lines, "\n"), start_line, start_col, end_line, end_col
end

local function send_to_ai_cli(payload)
  if vim.fn.executable("tmux") ~= 1 or not vim.env.TMUX or vim.env.TMUX == "" then
    vim.notify("tmux session not found. Copied payload to clipboard instead.", vim.log.levels.WARN)
    vim.fn.setreg("+", payload)
    return
  end

  local target = vim.g.ai_cli_target_pane or "{last}"

  vim.fn.system({ "tmux", "load-buffer", "-" }, payload)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to load tmux buffer for AI CLI context.", vim.log.levels.ERROR)
    return
  end

  vim.fn.system({ "tmux", "paste-buffer", "-d", "-t", target })
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to paste AI CLI context into tmux pane: " .. target, vim.log.levels.ERROR)
    return
  end

  vim.fn.system({ "tmux", "send-keys", "-t", target, "Enter" })
  if vim.v.shell_error ~= 0 then
    vim.notify("Context pasted, but sending Enter to the tmux pane failed.", vim.log.levels.WARN)
    return
  end

  vim.notify("Sent context to AI CLI pane: " .. target, vim.log.levels.INFO)
end

vim.keymap.set("n", "<C-p>", function()
  local relative_path = vim.fn.expand("%:.")
  local payload = string.format("%s", relative_path)

  send_to_ai_cli(payload)
end, { desc = "Send current file to AI CLI" })

vim.keymap.set("x", "<C-p>", function()
  local relative_path = vim.fn.expand("%:.")
  local _, start_line, start_col, end_line, end_col = get_visual_text()
  local payload = table.concat({
    string.format("%s:%d:%d-%d:%d", relative_path, start_line, start_col, end_line, end_col),
  }, "\n")

  send_to_ai_cli(payload)
end, { desc = "Send selection to AI CLI" })
