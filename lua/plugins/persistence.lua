local M = {}

function M.restore()
  require("persistence").load()

  vim.schedule(function()
    require("lazy").load({
      plugins = {
        "telescope.nvim",
        "lazygit.nvim",
      },
    })
  end)
end

function M.setup()
  require("persistence").setup({})

  vim.keymap.set("n", "<leader>ss", function()
    M.restore()
  end, { desc = "Restore session" })
end

return M
