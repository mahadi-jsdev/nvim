local M = {}

function M.setup()
  require("sidekick").setup({
    nes = {
      enabled = false,
    },
    cli = {
      win = {
        position = "right",
        width = 0.4,
      },
    },
  })

  local map = vim.keymap.set

  map("n", "<C-t>", function()
    require("sidekick.cli").toggle({ name = "claude" })
  end, { desc = "toggle" })

  map({ "n", "x" }, "<C-p>", function()
    require("sidekick.cli").prompt()
  end, { desc = "Open Claude Code" })
end

return M
