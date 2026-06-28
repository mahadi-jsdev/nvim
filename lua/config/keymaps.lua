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
map("n", "<C-v>", "<CMD>leftabove vsplit<CR>")

-- NvChad UI
map({ "n", "t" }, "<c-`>", function()
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

-- Snacks Pickers
local function directory_picker()
  local root = vim.fn.getcwd()
  local dirs = { { text = ".", _path = root } }
  local fd_output = vim.fn.systemlist({ "fdfind", "--type", "directory", "--follow", "--exclude", ".git", ".", root })
  if vim.v.shell_error == 0 then
    for _, path in ipairs(fd_output) do
      local label = vim.fs.relpath(root, path) or path
      table.insert(dirs, { text = label, _path = path })
    end
  end
  Snacks.picker.pick({
    title = "Search Directories",
    items = dirs,
    format = "text",
    layout = { hidden = { "preview" } },
    confirm = function(picker, item)
      picker:close()
      if item then require("yazi").yazi(nil, vim.fn.fnamemodify(item._path, ":p")) end
    end,
  })
end

map("n", ",", function() Snacks.picker.buffers() end, { desc = "search buffers" })
map("n", "<leader>fl", function() Snacks.picker.lines() end, { desc = "find lines" })
map("n", "<C-space>", directory_picker, { desc = "search directories" })
map("n", "<C-g>", function() Snacks.picker.git_status() end, { desc = "Git Status" })

-- Copy relative path to clipboard
vim.keymap.set("n", "<leader>cf", function()
  local relative_path = vim.fn.expand("%:.") -- Get path relative to cwd
  vim.fn.setreg("+", relative_path)          -- Write to system clipboard register
  notify_copy("Copied relative path: " .. relative_path)
end, { desc = "Copy relative file path to clipboard" })
