local M = {}

function M.setup()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("neo-tree").setup({
    sources = { "filesystem", "buffers", "git_status" },
    -- sources = { "buffers" },
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
      group_empty_dirs = true,
      show_unloaded = true,
    },
    source_selector = {
      winbar = true,
      statusline = false,
    },
    window = {
      width = 45,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
  })

  vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle buffers right<cr>", { desc = "Buffers" })
  vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem right<cr>", { desc = "Buffers" })
end

return M
