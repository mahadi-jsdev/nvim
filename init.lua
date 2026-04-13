require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/kevinhwang91/nvim-ufo",
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/mistweaverco/kulala.nvim",
  "https://github.com/jake-stewart/multicursor.nvim",
  "https://github.com/akinsho/toggleterm.nvim",
  -- "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/sainnhe/gruvbox-material"
})

require("plugins.telescope").setup()
require("plugins.lazygit").setup()
require("plugins.gitsigns").setup()
require("plugins.mini").setup()
require("plugins.neotree").setup()
require("plugins.mason").setup()
require("plugins.blink").setup()
require("plugins.nvim-lsp").setup()
require("plugins.conform").setup()
-- require("plugins.nvim-ufo").setup()
require("plugins.codediff").setup()
-- require("plugins.kulala").setup()
require("plugins.multicursor").setup()
require("plugins.toggleterm").setup()
-- require("plugins.treesitter").setup()
require("plugins.theme").setup()
