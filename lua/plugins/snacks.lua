return {
  "folke/snacks.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    picker = {},
    bigfile = {},
    quickfile = {},
    bufDelete = {},
    statuscolumn = {},
    scope = {},
    input = {},
    notifier = {},
    indent = {},
    explorer = {},
    dashboard = {},
    -- scratch = {},
    -- image = {},
    terminal = {},
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "explorer",
    },
    {
      "<C-t>",
      function()
        Snacks.terminal.toggle()
      end,
      mode = { "n" },
      desc = "Delete Buffer",
    },
    {
      "<C-t>",
      function()
        Snacks.terminal.toggle()
      end,
      mode = { "t" },
      desc = "Delete Buffer",
    },
  },
}
