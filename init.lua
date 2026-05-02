require("config.options")
require("config.keymaps")
require("config.autocmds")

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
    {
      "catppuccin/nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("plugins.theme").setup()
      end,
    },
    {
      "folke/snacks.nvim",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("plugins.snacks").setup()
      end,
    },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      opts = {},
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
      "mikavilpas/yazi.nvim",
      cmd = "Yazi",
      keys = { "-" },
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugins.yazi").setup()
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
      "mahadi-jsdev/deltaview.nvim",
      dependencies = {
        "kokusenz/delta.lua",
      },
      cmd = { "Delta", "DeltaMenu", "DeltaView" },
      keys = {
        { "<leader>dd", "<cmd>DeltaView<cr>", desc = "Delta view current file" },
      },
      config = function()
        require("deltaview").setup({
          use_nerdfonts = true,
        })
      end,
    },
    {
      "sudo-tee/opencode.nvim",
      keys = { "<C-o>" },
      cmd = "Opencode",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "MeanderingProgrammer/render-markdown.nvim",
      },
      config = function()
        require("plugins.opencode").setup()
      end,
    },
  },
  {
    defaults = {
      lazy = true,
    },
    checker = {
      enabled = false,
    },
  })
