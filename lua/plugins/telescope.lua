local M = {}

local function open_yazi(path)
  local ok, yazi = pcall(require, "yazi")
  if not ok then
    return
  end

  yazi.yazi(nil, path)
end

local function visual_selection()
  local _, start_row, start_col = table.unpack(vim.fn.getpos("'<"))
  local _, end_row, end_col = table.unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(start_row, end_row)

  if #lines == 0 then
    return ""
  end

  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  lines[1] = string.sub(lines[1], start_col)
  return table.concat(lines, "\n")
end

local function yazi_directory_picker()
  local root = vim.fn.getcwd()
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
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

  pickers
      .new({}, {
        prompt_title = "Search Directories",
        finder = finders.new_table({
          results = directories,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.label,
              ordinal = entry.label,
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            if selection then
              open_yazi(selection.value.path)
            end
          end)

          return true
        end,
      })
      :find()
end

function M.setup()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      path_display = { "smart" },
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })

  telescope.load_extension("ui-select")

  local builtin = require("telescope.builtin")
  local map = vim.keymap.set

  map("n", "<leader><leader>", builtin.find_files, { desc = "search files" })
  map("n", ",", function()
    builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
  end, { desc = "search buffers" })
  map("n", "<C-f>", builtin.live_grep, { desc = "Grep" })
  map("x", "<C-f>", function()
    builtin.grep_string({ search = visual_selection() })
  end, { desc = "Visual selection or word" })
  map("n", "<leader>fl", builtin.current_buffer_fuzzy_find, { desc = "find lines" })
  map("n", "<C-space>", yazi_directory_picker, { desc = "search directories" })
  map("n", "<C-g>", builtin.git_status, { desc = "Git Status" })
end

return M
