return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = vim.treesitter
    local original_get_node_text = ts.get_node_text

    ts.get_node_text = function(node, source, opts)
      if type(node) == "table" then
        node = node[1]
      end

      if not node then
        return ""
      end

      return original_get_node_text(node, source, opts)
    end

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
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
        "yaml",
        "bash",
        "python",
        "rust",
        "go",
        "java",
        "cpp",
        "c",
        "http",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
