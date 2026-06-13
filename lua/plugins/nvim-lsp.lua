local M = {}

function M.setup()
  local blink = require("blink.cmp")
  local capabilities = blink.get_lsp_capabilities() or {}

  local on_attach = function(_, bufnr)
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = bufnr }
    map("n", "<leader>lr", require("nvchad.lsp.renamer"), opts)
    map("n", "<leader>la", vim.lsp.buf.code_action, opts)
    map("n", "<leader>ld", vim.diagnostic.open_float, opts)
    map("n", "<leader>ff", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
      })
    end, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
    map("n", "gr", function() Snacks.picker.lsp_references() end, opts)
    map("n", "gs", function() Snacks.picker.lsp_symbols() end, opts)
    map("n", "<leader>fd", function() Snacks.picker.diagnostics() end, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
  end

  local servers = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "tailwindcss",
    "html",
    "cssls",
  }

  for _, lsp in ipairs(servers) do
    vim.lsp.config(lsp, {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    vim.lsp.enable(lsp)
  end

  vim.lsp.config("emmet_language_server", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "html",
      "css",
      "scss",
      "javascriptreact",
      "typescriptreact",
      "javascript",
      "less",
      "sass",
    },
    init_options = {
      includeLanguages = {},
      excludeLanguages = {},
      showAbbreviationSuggestions = true,
      showExpandedAbbreviation = "always",
      showSuggestionsAsSnippets = true,
      syntaxProfiles = {},
      variables = {},
    },
  })
  vim.lsp.enable("emmet_language_server")
end

return M
