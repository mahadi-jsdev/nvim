local M = {}

function M.setup()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    return
  end

  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")

  local function open_oil(path)
    local oil_ok, oil = pcall(require, "oil")
    if not oil_ok then
      return
    end

    oil.open(path)
  end

  local function open_oil_directory_picker()
    local root = vim.fn.getcwd()
    local directories = { "/root" }
    local fd_output = vim.fn.systemlist({ "fd", "--type", "directory", "--follow", "--exclude", ".git", ".", root })

    if vim.v.shell_error == 0 then
      vim.list_extend(directories, fd_output)
    end

    pickers.new({}, {
      prompt_title = "Search Directories",
      finder = finders.new_table({
        results = directories,
      }),
      previewer = false,
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if not selection then
            return
          end

          if selection[1] == "/root" then
            open_oil(root)
            return
          end

          open_oil(selection[1])
        end)

        return true
      end,
    }):find()
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

  local map = vim.keymap.set
  map("n", "<leader><leader>", builtin.find_files, { desc = "search files" })
  map("n", ",", builtin.buffers, { desc = "search buffers" })
  map("n", "<C-f>", builtin.live_grep, { desc = "Grep" })
  map("x", "<C-f>", builtin.grep_string, { desc = "Visual selection or word" })
  map("n", "<leader>fl", builtin.current_buffer_fuzzy_find, { desc = "find lines" })
  map("n", "<leader>e", open_oil_directory_picker, { desc = "search directories" })
  map("n", "<C-g>", builtin.git_status, { desc = "Git Status" })
  map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return M
