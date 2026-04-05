local map = vim.keymap.set

local function notify_copy(message)
  vim.schedule(function()
    vim.notify(message, vim.log.levels.INFO, { title = "Clipboard" })
  end)
end

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


-- line number selection
vim.keymap.set("x", "<leader>cv", function()
  local relative_path = vim.fn.expand("%:.")
  local start_line = vim.fn.line("v")
  local start_col = vim.fn.col("v")
  local end_line = vim.fn.line(".")
  local end_col = vim.fn.col(".")
  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end
  if vim.fn.mode() == "V" then
    start_col = 1
    end_col = math.max(vim.fn.col({ end_line, "$" }) - 1, 1)
  end
  local reference = string.format(
    "@%s:%d:%d-%d:%d",
    relative_path,
    start_line,
    start_col,
    end_line,
    end_col
  )
  vim.fn.setreg("+", reference)
  notify_copy("Copied selection reference: " .. reference)
end, { desc = "Copy selection reference" })

-- line numbers and copy selection
vim.keymap.set("x", "<leader>cV", function()
  local relative_path = vim.fn.expand("%:.")
  local start_line = vim.fn.line("v")
  local start_col = vim.fn.col("v")
  local end_line = vim.fn.line(".")
  local end_col = vim.fn.col(".")
  local mode = vim.fn.mode()

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  if mode == "V" then
    start_col = 1
    end_col = math.max(vim.fn.col({ end_line, "$" }) - 1, 1)
  end

  local selected_text

  if mode == "V" then
    selected_text = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  else
    selected_text = table.concat(
      vim.api.nvim_buf_get_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, {}),
      "\n"
    )
  end

  local reference = string.format(
    "@%s:%d:%d-%d:%d",
    relative_path,
    start_line,
    start_col,
    end_line,
    end_col
  )
  local payload = reference .. "\n\n" .. selected_text

  vim.fn.setreg("+", payload)
  notify_copy("Copied selection reference and text: " .. reference)
end, { desc = "Copy selection reference and text" })
