local M = {}

function M.setup()
  local blink = require("blink.cmp")
  local capabilities = blink.get_lsp_capabilities() or {}

  local on_attach = function(_, bufnr)
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = bufnr }

    map("n", "<leader>lr", vim.lsp.buf.rename, opts)
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
    map("n", "gd", builtin.lsp_definitions, opts)
    map("n", "gr", builtin.lsp_references, opts)
    map("n", "gs", builtin.lsp_document_symbols, opts)
    map("n", "<leader>fd", builtin.diagnostics, opts)
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
