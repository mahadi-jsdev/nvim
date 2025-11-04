return {
  'mawkler/jsx-element.nvim',
  event = "BufRead",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  ft = { 'typescriptreact', 'javascriptreact', 'javascript' },
  opts = {},
}
