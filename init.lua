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
    "sainnhe/gruvbox-material",
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
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      "<leader><leader>",
      ",",
      "<C-f>",
      "<leader>fl",
      "<C-space>",
      "<C-g>",
      "-",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "mikavilpas/yazi.nvim",
    },
    config = function()
      require("plugins.telescope").setup()
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
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("plugins.mason").setup()
      require("plugins.nvim-lsp").setup()
    end,
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
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
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = { "<leader>cd" },
    config = function()
      require("plugins.codediff").setup()
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
    "sudo-tee/opencode.nvim",
    event = "VeryLazy",
    keys = { "<C-o>" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    config = function()
      require("plugins.opencode").setup()
    end,
  },
  {
    "MeanderingProgrammer/harpoon-core.nvim",
    keys = {
      "<leader>ml",
      "<leader>ma",
      "<leader>mr",
      "<C-l>",
      "<C-h>",
      "<A-1>",
      "<A-2>",
      "<A-3>",
      "<A-4>",
      "<A-5>",
    },
    config = function()
      require("plugins.harpoon-core").setup()
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = { "<C-t>" },
    config = function()
      require("plugins.toggleterm").setup()
    end,
  },
}, {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "gruvbox-material" },
  },
})
