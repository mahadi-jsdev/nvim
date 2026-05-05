local M = {}

function M.setup()
  local function open_yazi(path)
    local ok, yazi = pcall(require, "yazi")
    if not ok then
      return
    end

    yazi.yazi(nil, path)
  end

  local function open_yazi_directory_picker()
    local root = vim.fn.getcwd()
    local directories = {
      { label = ".", path = root },
    }
    local fd_output = vim.fn.systemlist({ "fd", "--type", "directory", "--follow", "--exclude", ".git", ".", root })

    if vim.v.shell_error == 0 then
      for _, path in ipairs(fd_output) do
        table.insert(directories, {
          label = vim.fs.relpath(root, path) or path,
          path = path,
        })
      end
    end

    vim.ui.select(directories, {
      prompt = "Search Directories",
      format_item = function(item)
        return item.label
      end,
    }, function(choice)
      if not choice then
        return
      end

      open_yazi(choice.path)
    end)
  end

  require("snacks").setup({
    picker = {},
    explorer = {},
    indent = {},
    statuscolumn = {}
  })

  local map = vim.keymap.set
  map("n", "<leader><leader>", function()
    Snacks.picker.files()
  end, { desc = "search files" })
  map("n", "<leader>e", function()
    Snacks.explorer()
  end, { desc = "file explorer" })
  map("n", ",", function()
    Snacks.picker.buffers({ sort_lastused = true, current = false })
  end, { desc = "search buffers" })
  map("n", "<C-f>", function()
    Snacks.picker.grep()
  end, { desc = "Grep" })
  map("x", "<C-f>", function()
    Snacks.picker.grep_word()
  end, { desc = "Visual selection or word" })
  map("n", "<leader>fl", function()
    Snacks.picker.lines()
  end, { desc = "find lines" })
  map("n", "<C-space>", open_yazi_directory_picker, { desc = "search directories" })
  map("n", "<C-g>", function()
    Snacks.picker.git_status()
  end, { desc = "Git Status" })
end

return M
