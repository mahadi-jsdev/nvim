return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  opts = {},
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99

    -- Setup with nvim lsp provider
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    require('ufo').setup({
      provider_selector = function()
        return { 'lsp', 'indent', "treesitter", }
      end
    })
  end,
}
