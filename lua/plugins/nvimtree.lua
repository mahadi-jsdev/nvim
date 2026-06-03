local M = {}

function M.open_current_folder()
  local api = require("nvim-tree.api")
  local name = vim.api.nvim_buf_get_name(0)
  local path = name ~= "" and vim.fn.fnamemodify(name, ":p:h") or vim.fn.getcwd()

  api.tree.open({ path = path })
end

function M.setup()
  dofile(vim.g.base46_cache .. "nvimtree")

  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      width = 28,
      side = "left",
      preserve_window_proportions = true,
      signcolumn = "no",
    },
    renderer = {
      root_folder_label = false,
      highlight_git = true,
      indent_width = 1,
      indent_markers = {
        enable = true,
      },
      icons = {
        padding = " ",
        git_placement = "after",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = true,
      git_ignored = true,
    },
    git = {
      enable = true,
      ignore = false,
    },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
      },
    },
  })

  vim.keymap.set("n", "-", M.open_current_folder, { desc = "Open nvim-tree folder" })
end

return M
