local M = {}

function M.setup()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end

  treesitter.setup()

  local languages = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "json",
    "yaml",
    "bash",
    "markdown",
    "markdown_inline",
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = languages,
    callback = function(args)
      vim.treesitter.start(args.buf)
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function(args)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
