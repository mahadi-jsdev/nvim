local M = {}

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
  "markdown",
  "markdown_inline",
  "bash",
  "python",
  "rust",
  "go",
  "java",
  "cpp",
  "c",
  "http",
}

function M.setup()
  local ok, ts = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end

  ts.setup({})
  ts.install(languages)

  local group = vim.api.nvim_create_augroup("NvimTreesitterFeatures", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
