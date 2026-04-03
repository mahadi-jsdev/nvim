local session_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "sessions")

local function get_global_session_name()
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  return cwd:gsub("^/", ""):gsub("[/\\:]", "%%") .. ".vim"
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("mini-session-local", { clear = true }),
  callback = function()
    local has_listed_buffer = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
        has_listed_buffer = true
        break
      end
    end

    if has_listed_buffer then
      MiniSessions.write(get_global_session_name(), { force = true, verbose = false })
    end
  end,
  desc = "Write project mini session to global session directory on exit",
})

return {
  "nvim-mini/mini.nvim",
  branch = "stable",
  version = "*",
  config = function()
    require("mini.tabline").setup()
    require("mini.statusline").setup()
    require('mini.icons').setup()
    require('mini.pairs').setup()
    require('mini.starter').setup()
    require('mini.comment').setup()
    require('mini.git').setup()
    require("mini.bufremove").setup()
    vim.fn.mkdir(session_dir, "p")
    require('mini.sessions').setup({
      directory = session_dir,
      file = "",
    })

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


    -- git commit from terminal
    map("n", "<leader>gc", "<Cmd>Git commit<CR>", { desc = "Git commit" })

    -- cycle between buffer
    map("n", "<C-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })
    map("n", "<C-h>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
    map("n", "<C-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })
    map("n", "<C-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
  end,
}
