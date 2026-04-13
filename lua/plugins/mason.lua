local M = {}

function M.setup()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = ">",
        package_uninstalled = "x",
      },
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "eslint",
      "tailwindcss",
      "html",
      "cssls",
      "emmet_language_server",
    },
    automatic_enable = false,
  })
end

return M
