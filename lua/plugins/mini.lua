return {
  "nvim-mini/mini.nvim",
  branch = "stable",
  version = "*",
  event = "BufRead",
  config = function()
    -- require("mini.tabline").setup()
    require("mini.statusline").setup()
    require('mini.icons').setup()
    require('mini.pairs').setup()
    require('mini.comment').setup()
    require('mini.git').setup()
    require("mini.bufremove").setup()

    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        warning = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
