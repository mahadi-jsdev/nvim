local M = {}

function M.setup()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    return
  end

  telescope.setup({
    defaults = {
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
    },
    pickers = {
      buffers = {
        sort_mru = true,
        sort_lastused = true,
        ignore_current_buffer = true,
      },
    },
  })

  pcall(telescope.load_extension, "fzf")

  local builtin = require("telescope.builtin")
  local map = vim.keymap.set

  map("n", "<leader><leader>", builtin.find_files, { desc = "search files" })
  map("n", ",", builtin.buffers, { desc = "buffers" })
  map("n", "<C-f>", builtin.live_grep, { desc = "Grep" })
  map("x", "<C-f>", builtin.grep_string, { desc = "Visual selection or word" })
  map("n", "<leader>fl", builtin.current_buffer_fuzzy_find, { desc = "find lines" })
  map("n", "<C-g>", builtin.git_status, { desc = "Git Status" })
end

return M
