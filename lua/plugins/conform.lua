local M = {}

function M.setup()
  local prettier_formatters = {
    "prettierd",
    "prettier",
    stop_after_first = true,
  }

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = prettier_formatters,
      javascriptreact = prettier_formatters,
      typescript = prettier_formatters,
      typescriptreact = prettier_formatters,
      html = prettier_formatters,
      css = prettier_formatters,
      scss = prettier_formatters,
      json = prettier_formatters,
      jsonc = prettier_formatters,
      markdown = prettier_formatters,
      yaml = prettier_formatters,
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end

return M
