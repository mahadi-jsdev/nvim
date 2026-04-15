local M = {}

function M.setup()
  require("mini.statusline").setup()
  require("mini.icons").setup()
  require("mini.pairs").setup()
  require("mini.comment").setup()
  require("mini.git").setup()
  require("mini.bufremove").setup()
  require('mini.pick').setup()

  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      warning = { pattern = "%f[%w]()WARNING()%f[%W]", group = "MiniHipatternsHack" },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })


  vim.keymap.set("n", "<C-x>", function()
    require("mini.bufremove").delete(0, false)
  end, { desc = "Close buffer" })
end

return M
