local M = {}

local session_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "sessions")

local function get_global_session_name()
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  return cwd:gsub("^/", ""):gsub("[/\\:]", "-") .. ".vim"
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

function M.setup()
  require("mini.statusline").setup()
  require("mini.icons").setup()
  require("mini.pairs").setup()
  require("mini.comment").setup()
  require("mini.git").setup()
  require("mini.bufremove").setup()
  require('mini.pick').setup()
  require("mini.starter").setup()

  -- mini session management
  vim.fn.mkdir(session_dir, "p")
  require('mini.sessions').setup({
    directory = session_dir,
    file = "",
  })

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
