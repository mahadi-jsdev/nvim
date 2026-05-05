local M = {}

local function close_theme_picker()
  local state = require("nvchad.themes.state")
  local bufs = {}

  for _, win in ipairs({ state.win, state.input_win }) do
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    table.insert(bufs, state.buf)
  end

  if state.input_buf and vim.api.nvim_buf_is_valid(state.input_buf) then
    table.insert(bufs, state.input_buf)
  end

  if #bufs > 0 then
    for _, buf in ipairs(bufs) do
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end

  vim.cmd.stopinsert()
end

local function persist_theme(name)
  local path = vim.fn.stdpath("config") .. "/lua/chadrc.lua"
  local file = io.open(path, "r")

  if not file then
    vim.notify("Could not open chadrc.lua", vim.log.levels.ERROR)
    return
  end

  local content = file:read("*all")
  file:close()

  local updated, count = content:gsub('(theme%s*=%s*)"[^"]+"', '%1"' .. name .. '"', 1)

  if count == 0 then
    vim.notify("Could not find base46 theme in chadrc.lua", vim.log.levels.ERROR)
    return
  end

  local toggle_pattern = 'theme_toggle%s*=%s*{%s*"[^"]+"%s*,%s*"[^"]+"%s*}'
  local toggle_value = 'theme_toggle = { "' .. name .. '", "one_light" }'
  local toggle_count
  updated, toggle_count = updated:gsub(toggle_pattern, toggle_value, 1)

  if toggle_count == 0 then
    updated = updated:gsub('(theme%s*=%s*"[^"]+"%s*,)', '%1\n  ' .. toggle_value .. ',', 1)
  end

  file = io.open(path, "w")

  if not file then
    vim.notify("Could not write chadrc.lua", vim.log.levels.ERROR)
    return
  end

  file:write(updated)
  file:close()
end

function M.open_theme_picker(opts)
  opts = opts or {}
  opts.mappings = function(input_buf)
    vim.keymap.set({ "i", "n" }, "<CR>", function()
      local state = require("nvchad.themes.state")
      local name = state.themes_shown[state.index]

      if not name then
        return
      end

      state.confirmed = true
      persist_theme(name)
      require("nvchad.themes.utils").reload_theme(name)
      close_theme_picker()
    end, { buffer = input_buf })
  end

  require("nvchad.themes").open(opts)
end

return M
