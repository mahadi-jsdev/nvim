require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      config = function()
        require("plugins.persistence").setup()
      end,
    },
    {
      "kdheepak/lazygit.nvim",
      cmd = "LazyGit",
      keys = { "<leader>gg" },
      config = function()
        require("plugins.lazygit").setup()
      end,
    },
    {
      "mistweaverco/kulala.nvim",
      keys = {
        { "<leader>rs", desc = "Send request" },
        { "<leader>ra", desc = "Send all requests" },
        { "<leader>rb", desc = "Open scratchpad" },
      },
      ft = { "http", "rest" },
      config = function()
        require("plugins.kulala").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("plugins.gitsigns").setup()
      end,
    },
    {
      "nvim-mini/mini.nvim",
      event = "VeryLazy",
      config = function()
        require("plugins.mini").setup()
      end,
    },
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "saghen/blink.cmp",
      },
      config = function()
        require("plugins.mason").setup()
        require("plugins.nvim-lsp").setup()
      end,
    },
    {
      "saghen/blink.cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = {
        "saghen/blink.lib",
      },
      build = function()
        require("blink.cmp").build():wait(60000)
      end,
      config = function()
        require("plugins.blink").setup()
      end,
    },
    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("plugins.conform").setup()
      end,
    },
    {
      "chrisgrieser/nvim-origami",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("plugins.origami").setup()
      end,
    },
    {
      "nvchad/ui",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvchad/base46",
        "nvchad/volt",
      },
    },
    {
      "nvchad/volt",
      lazy = true,
    },
    {
      "nvchad/base46",
      lazy = true,
      build = function()
        require("base46").load_all_highlights()
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPost", "BufNewFile" },
      build = ":TSUpdate",
      config = function()
        require("plugins.treesitter").setup()
      end,
    },
    {
      'akinsho/bufferline.nvim',
      version = "*",
      event = "BufRead",
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("plugins.bufferline").setup()
      end
    },
    {
      "stevearc/oil.nvim",
      lazy = false,
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("plugins.oil").setup()
      end,
    },
    {
      "esmuellert/codediff.nvim",
      cmd = "CodeDiff",
      keys = {
        { "<leader>cd", "<cmd>CodeDiff<cr>", desc = "CodeDiff toggle" },
      },
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        bigfile = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
      },
      keys = {
        { "<leader>e", function() require("snacks").explorer() end, desc = "Toggle Explorer" },
      },
    }
  },
  {
    defaults = {
      lazy = true,
    },
    checker = {
      enabled = false,
    },
  })

-- Load cached Base46 highlights for NvChad UI components.
if vim.fn.isdirectory(vim.g.base46_cache) == 0 then
  require("base46").load_all_highlights()
end

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

require("nvchad")

local opening_file = vim.api.nvim_buf_get_name(0)
local is_startup_buffer = opening_file == "" and not vim.bo.modified

if is_startup_buffer then
  require("nvchad.nvdash").open(vim.api.nvim_get_current_buf())
end
