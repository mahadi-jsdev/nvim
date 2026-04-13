local M = {}

function M.setup()
  vim.opt.foldlevel = 99
  vim.opt.foldlevelstart = 99
  vim.opt.foldenable = true

  require("ufo").setup({
    provider_selector = function()
      return { "lsp", "indent", "treesitter" }
    end,
  })
end

return M
