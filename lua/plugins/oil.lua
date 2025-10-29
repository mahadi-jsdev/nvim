return {
  "stevearc/oil.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  keys = {
    {
      "-",
      mode = { "n", "v" },
      function()
        require("oil").open()
      end,
      desc = "Open parent directory",
    },
  },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = true,
    },
    watch_for_changes = true,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["q"] = "actions.close",
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1

    -- Folders only function
    local function folders_only()
      local fd_cmd = "fdfind --type d --hidden --exclude .git"
      local fd_handle = io.popen(fd_cmd)
      local results = {}
      if fd_handle then
        for line in fd_handle:lines() do
          local abs_path = vim.fn.fnamemodify(line, ":p")
          local display = line
          table.insert(results, { path = abs_path, display = display })
        end
        fd_handle:close()
      end
      -- add project root (cwd) at the very top
      local cwd = vim.fn.getcwd()
      table.insert(results, 1, {
        path = cwd,
        display = "root",
      })
      vim.ui.select(results, {
        prompt = "Folders:",
        format_item = function(item)
          return item.display
        end,
      }, function(selected)
        if not selected then
          return
        end
        require("oil").open(selected.path)
      end)
    end

    -- Set up key mapping for folders only
    vim.api.nvim_set_keymap("n", "<C-e>", "", {
      noremap = true,
      silent = true,
      desc = "Folders only (Oil compatible)",
      callback = folders_only,
    })
  end,
}
