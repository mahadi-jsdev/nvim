return {
  "nvim-mini/mini.nvim",
  branch = "stable",
  version = "*",
  event = "BufRead",
  config = function()
    require("mini.tabline").setup()
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

    local map = vim.keymap.set

    -- delete buffer
    vim.keymap.set("n", "<C-x>", function()
      require("mini.bufremove").delete(0, false)
    end, { desc = "Delete Buffer" })

    -- cycle between buffer
    map("n", "<C-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })
    map("n", "<C-h>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
    map("n", "<C-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })
    map("n", "<C-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
  end,
}
