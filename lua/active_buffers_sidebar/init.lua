local M = {}

local defaults = {
  position = "left",
  width = 28,
  show_unlisted = false,
  highlight = {
    active = "ActiveBuffersSidebarCurrent",
    inactive = "ActiveBuffersSidebarInactive",
  },
}

local state = {
  buf = nil,
  win = nil,
  line_map = {},
  opts = vim.deepcopy(defaults),
  last_real_buf = nil,
  last_real_win = nil,
  augroup = nil,
  namespace = vim.api.nvim_create_namespace("active-buffers-sidebar"),
}

local function is_valid_buf(bufnr)
  return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

local function is_valid_win(winid)
  return winid and vim.api.nvim_win_is_valid(winid)
end

local function is_sidebar_buf(bufnr)
  return is_valid_buf(bufnr) and state.buf == bufnr
end

local function is_sidebar_win(winid)
  return is_valid_win(winid) and state.win == winid
end

local function normalize_position(position)
  if position == "right" then
    return "right"
  end

  return "left"
end

local function list_buffers()
  local buffers = {}

  for _, info in ipairs(vim.fn.getbufinfo()) do
    local is_listed = info.listed == 1
    if (state.opts.show_unlisted or is_listed) and is_valid_buf(info.bufnr) then
      local name = vim.api.nvim_buf_get_name(info.bufnr)
      if name ~= "" then
        local display_name = vim.fn.fnamemodify(name, ":t")

        table.insert(buffers, {
          bufnr = info.bufnr,
          name = display_name,
          changed = vim.bo[info.bufnr].modified,
        })
      end
    end
  end

  table.sort(buffers, function(a, b)
    return a.bufnr < b.bufnr
  end)

  return buffers
end

local function get_active_buf()
  local current = vim.api.nvim_get_current_buf()
  if not is_sidebar_buf(current) then
    return current
  end

  if is_valid_buf(state.last_real_buf) then
    return state.last_real_buf
  end

  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    if not is_sidebar_buf(bufnr) then
      return bufnr
    end
  end
end

local function list_real_windows()
  local windows = {}

  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if not is_sidebar_win(winid) then
      table.insert(windows, winid)
    end
  end

  return windows
end

local function find_replacement_buf(exclude)
  for _, buffer in ipairs(list_buffers()) do
    if buffer.bufnr ~= exclude then
      return buffer.bufnr
    end
  end
end

local function ensure_highlights()
  vim.api.nvim_set_hl(0, defaults.highlight.active, {
    default = true,
    link = "Visual",
  })

  vim.api.nvim_set_hl(0, defaults.highlight.inactive, {
    default = true,
    link = "Comment",
  })
end

local function ensure_sidebar_buf()
  if is_valid_buf(state.buf) then
    return state.buf
  end

  state.buf = vim.api.nvim_create_buf(false, true)
  vim.bo[state.buf].bufhidden = "hide"
  vim.bo[state.buf].buftype = "nofile"
  vim.bo[state.buf].filetype = "active-buffers-sidebar"
  vim.bo[state.buf].modifiable = false
  vim.bo[state.buf].swapfile = false

  local function jump_to_line()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local target = state.line_map[line]

    if not is_valid_buf(target) then
      M.refresh()
      return
    end

    local target_win = state.last_real_win
    if not is_valid_win(target_win) or is_sidebar_win(target_win) then
      target_win = nil
      for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if not is_sidebar_win(winid) then
          target_win = winid
          break
        end
      end
    end

    if not is_valid_win(target_win) then
      local cmd = state.opts.position == "left" and "rightbelow vnew" or "leftabove vnew"
      vim.cmd(cmd)
      target_win = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_set_current_win(target_win)
    vim.api.nvim_win_set_buf(target_win, target)
    state.last_real_win = target_win
    state.last_real_buf = target
    M.refresh()
  end

  vim.keymap.set("n", "<CR>", jump_to_line, {
    buffer = state.buf,
    nowait = true,
    silent = true,
    desc = "Open selected buffer",
  })

  vim.keymap.set("n", "<LeftMouse>", jump_to_line, {
    buffer = state.buf,
    nowait = true,
    silent = true,
    desc = "Open clicked buffer",
  })

  vim.keymap.set("n", "<2-LeftMouse>", jump_to_line, {
    buffer = state.buf,
    nowait = true,
    silent = true,
    desc = "Open clicked buffer",
  })

  return state.buf
end

local function configure_sidebar_win(winid)
  vim.wo[winid].cursorline = false
  vim.wo[winid].foldcolumn = "0"
  vim.wo[winid].list = false
  vim.wo[winid].number = false
  vim.wo[winid].relativenumber = false
  vim.wo[winid].signcolumn = "no"
  vim.wo[winid].spell = false
  vim.wo[winid].statuscolumn = ""
  vim.wo[winid].winfixwidth = true
  vim.wo[winid].wrap = false
  vim.wo[winid].winhighlight = table.concat({
    "Normal:Normal",
    "EndOfBuffer:EndOfBuffer",
  }, ",")
end

local function render()
  if not is_valid_buf(state.buf) then
    return
  end

  local buffers = list_buffers()
  local active_buf = get_active_buf()
  local lines = {}

  state.line_map = {}

  if #buffers == 0 then
    lines = { " No active buffers" }
  else
    for index, buffer in ipairs(buffers) do
      local prefix = buffer.bufnr == active_buf and "▎" or " "
      local modified = buffer.changed and " [+]" or ""
      lines[index] = string.format("%s %d %s%s", prefix, buffer.bufnr, buffer.name, modified)
      state.line_map[index] = buffer.bufnr
    end
  end

  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(state.buf, state.namespace, 0, -1)

  for line, bufnr in pairs(state.line_map) do
    if bufnr == active_buf then
      vim.api.nvim_buf_add_highlight(state.buf, state.namespace, state.opts.highlight.active, line - 1, 0, -1)
    end
  end
end

local function ensure_main_window(closed_win, deleted_buf)
  if not is_valid_win(state.win) then
    return
  end

  local real_windows = list_real_windows()
  if #real_windows > 0 then
    if closed_win and state.last_real_win == closed_win then
      state.last_real_win = real_windows[1]
      state.last_real_buf = vim.api.nvim_win_get_buf(real_windows[1])
    end
    return
  end

  local replacement = find_replacement_buf(deleted_buf)
  local focus_back = vim.api.nvim_get_current_win()
  local cmd = state.opts.position == "left" and "rightbelow vnew" or "leftabove vnew"

  vim.api.nvim_set_current_win(state.win)
  vim.cmd(cmd)

  local new_win = vim.api.nvim_get_current_win()
  if replacement and is_valid_buf(replacement) then
    vim.api.nvim_win_set_buf(new_win, replacement)
  end

  state.last_real_win = new_win
  state.last_real_buf = replacement or vim.api.nvim_win_get_buf(new_win)

  if is_valid_win(focus_back) and not is_sidebar_win(focus_back) then
    vim.api.nvim_set_current_win(focus_back)
  else
    vim.api.nvim_set_current_win(new_win)
  end
end

local function create_sidebar_win()
  local current_win = vim.api.nvim_get_current_win()
  local split_cmd = state.opts.position == "right" and "botright vsplit" or "topleft vsplit"

  vim.cmd(split_cmd)
  state.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(state.win, state.opts.width)
  vim.api.nvim_win_set_buf(state.win, ensure_sidebar_buf())
  configure_sidebar_win(state.win)

  if is_valid_win(current_win) and current_win ~= state.win then
    vim.api.nvim_set_current_win(current_win)
  end
end

local function update_last_real_location(args)
  local bufnr = args and args.buf or vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()

  if is_sidebar_buf(bufnr) or is_sidebar_win(winid) then
    return
  end

  state.last_real_buf = bufnr
  state.last_real_win = winid
end

function M.refresh()
  if not is_valid_win(state.win) then
    state.win = nil
    return
  end

  if not is_valid_buf(state.buf) then
    state.buf = nil
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
    return
  end

  if vim.api.nvim_win_get_buf(state.win) ~= state.buf then
    vim.api.nvim_win_set_buf(state.win, state.buf)
  end

  vim.api.nvim_win_set_width(state.win, state.opts.width)
  configure_sidebar_win(state.win)
  render()
end

function M.open()
  ensure_highlights()
  ensure_sidebar_buf()

  if not is_valid_win(state.win) then
    create_sidebar_win()
  end

  M.refresh()
end

function M.close()
  if is_valid_win(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  state.win = nil
end

function M.toggle()
  if is_valid_win(state.win) then
    M.close()
    return
  end

  M.open()
end

function M.set_position(position)
  state.opts.position = normalize_position(position)

  if is_valid_win(state.win) then
    M.close()
    M.open()
  end
end

function M.setup(opts)
  state.opts = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
  state.opts.position = normalize_position(state.opts.position)
  ensure_highlights()

  state.augroup = vim.api.nvim_create_augroup("ActiveBuffersSidebar", { clear = true })

  vim.api.nvim_create_user_command("ActiveBuffersSidebarOpen", function()
    M.open()
  end, {})

  vim.api.nvim_create_user_command("ActiveBuffersSidebarClose", function()
    M.close()
  end, {})

  vim.api.nvim_create_user_command("ActiveBuffersSidebarToggle", function()
    M.toggle()
  end, {})

  vim.api.nvim_create_user_command("ActiveBuffersSidebarLeft", function()
    M.set_position("left")
  end, {})

  vim.api.nvim_create_user_command("ActiveBuffersSidebarRight", function()
    M.set_position("right")
  end, {})

  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = state.augroup,
    callback = function(args)
      update_last_real_location(args)
      vim.schedule(M.refresh)
    end,
  })

  vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufModifiedSet", "BufFilePost", "BufWipeout" }, {
    group = state.augroup,
    callback = function(args)
      if args.buf == state.last_real_buf then
        state.last_real_buf = find_replacement_buf(args.buf)
      end
      vim.schedule(M.refresh)
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    group = state.augroup,
    callback = function(args)
      if state.win and tostring(state.win) == args.match then
        state.win = nil
        return
      end

      local closed_win = tonumber(args.match)
      vim.schedule(function()
        ensure_main_window(closed_win)
        M.refresh()
      end)
    end,
  })
end

return M
