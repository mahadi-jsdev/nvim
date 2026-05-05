local M = {}

local function open_nvim_tree_folder(path)
  local ok, api = pcall(require, "nvim-tree.api")
  if not ok then
    return
  end

  api.tree.open({ path = vim.fn.fnamemodify(path, ":p") })
end

local function visual_selection()
  local saved_reg = vim.fn.getreg("z")
  local saved_regtype = vim.fn.getregtype("z")

  vim.cmd([[normal! "zy]])
  local selection = vim.fn.getreg("z")
  vim.fn.setreg("z", saved_reg, saved_regtype)

  return selection
end

local function directory_picker()
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
              open_nvim_tree_folder(selection.value.path)
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

  telescope.load_extension("fzf")
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
  map("n", "<C-space>", directory_picker, { desc = "search directories" })
  map("n", "<C-g>", builtin.git_status, { desc = "Git Status" })
end

return M
