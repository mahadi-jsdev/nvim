return {
  "nvim-neorg/neorg",
  lazy = true,   -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  opts = {
    load = {
      ["core.defaults"] = {},      -- Loads default behaviour
      ["core.concealer"] = {
        icon_preset = "nerd-font", -- Choose between "default", "codicons" or "nerd-font"
      },
      ["core.integrations.telescope"] = {
        config = {
          insert_file_link = {
            -- Whether to show the title preview in telescope. Affects performance with a large
            -- number of files.
            show_title_preview = true,
          },
        }
      },
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
          default_workspace = "notes",
        },
      },
    },
  },
  keys = {
    { "<leader>nn", "<cmd>Neorg<cr>", },
    { "<leader>ns", "<cmd>Telescope neorg search_headings<cr>", },
    { "<leader>nf", "<cmd>Telescope neorg insert_file_link<cr>", },
    { "<leader>nl", "<cmd>Telescope neorg insert_link<cr>", },
  }
}
