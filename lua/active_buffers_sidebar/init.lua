local M = {}

local defaults = {
  position = "left",
  width = 28,
  show_unlisted = false,
  highlight = {
    active = "ActiveBuffersSidebarCurrent",
    inactive = "ActiveBuffersSidebarInactive",
    icon = "ActiveBuffersSidebarIcon",
    accent = "ActiveBuffersSidebarAccent",
    modified = "ActiveBuffersSidebarModified",
    unstaged = "ActiveBuffersSidebarUnstaged",
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

local function get_hl(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok then
    return hl
  end

  return {}
end

local function get_hl_fg(name)
  return get_hl(name).fg
end

local function get_devicon(path)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return "󰈚", state.opts.highlight.icon
  end

  local filename = vim.fn.fnamemodify(path, ":t")
  local ext = vim.fn.fnamemodify(path, ":e")
  local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
  return icon or "󰈚", icon_hl or state.opts.highlight.icon
end

local function has_unstaged_changes(bufnr)
  if vim.bo[bufnr].modified then
    return false
  end

  local status = vim.b[bufnr].gitsigns_status_dict
  if type(status) ~= "table" then
    return false
  end

  return (status.added or 0) > 0 or (status.changed or 0) > 0 or (status.removed or 0) > 0
end

local function split_path_parts(path)
  local normalized = vim.fn.fnamemodify(path, ":~:.")
  local parts = vim.split(normalized, "/", { plain = true, trimempty = true })

  if vim.endswith(normalized, "/") then
    table.remove(parts, #parts)
  end

  return parts
end

local function build_display_names(buffers)
  local grouped = {}

  for _, buffer in ipairs(buffers) do
    grouped[buffer.name] = grouped[buffer.name] or {}
    table.insert(grouped[buffer.name], buffer)
  end

  for _, group in pairs(grouped) do
    if #group == 1 then
      group[1].display_name = group[1].name
    else
      for _, buffer in ipairs(group) do
        buffer.path_parts = split_path_parts(buffer.full_name)
        buffer.display_name = buffer.name
      end

      local depth = 1
      local unresolved = true

      while unresolved do
        unresolved = false
        local seen = {}

        for _, buffer in ipairs(group) do
          local parts = buffer.path_parts
          local filename_index = #parts
          local start_index = math.max(1, filename_index - depth)
          local candidate = table.concat(vim.list_slice(parts, start_index, filename_index), "/")

          buffer.display_name = candidate ~= "" and candidate or buffer.name
          seen[buffer.display_name] = seen[buffer.display_name] or 0
          seen[buffer.display_name] = seen[buffer.display_name] + 1
        end

        for _, count in pairs(seen) do
          if count > 1 then
            unresolved = true
            depth = depth + 1
            break
          end
        end

        if depth > 12 then
          break
        end
      end
    end
  end
end

local function truncate_from_left(text, max_width)
  if max_width <= 0 then
    return ""
  end

  if vim.fn.strdisplaywidth(text) <= max_width then
    return text
  end

  local ellipsis = "…"
  local target_width = max_width - vim.fn.strdisplaywidth(ellipsis)

  if target_width <= 0 then
    return ellipsis
  end

  local chars = vim.fn.strchars(text)
  local result = ""

  for index = chars, 1, -1 do
    local char = vim.fn.strcharpart(text, index - 1, 1)
    if vim.fn.strdisplaywidth(char .. result) > target_width then
      break
    end
    result = char .. result
  end

  return ellipsis .. result
end

local function list_buffers()
  local buffers = {}

  for _, info in ipairs(vim.fn.getbufinfo()) do
    local is_listed = info.listed == 1
    if (state.opts.show_unlisted or is_listed) and is_valid_buf(info.bufnr) then
      local name = vim.api.nvim_buf_get_name(info.bufnr)
      if name ~= "" then
        local display_name = vim.fn.fnamemodify(name, ":t")
        local icon, icon_hl = get_devicon(name)

        table.insert(buffers, {
          bufnr = info.bufnr,
          full_name = name,
          name = display_name,
          changed = vim.bo[info.bufnr].modified,
          unstaged = has_unstaged_changes(info.bufnr),
          icon = icon,
          icon_hl = icon_hl,
        })
      end
    end
  end

  table.sort(buffers, function(a, b)
    return a.bufnr < b.bufnr
  end)

  build_display_names(buffers)

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
  local normal = get_hl("Normal")
  local visual = get_hl("Visual")
  local comment_fg = get_hl_fg("Comment")
  local function_fg = get_hl_fg("Function")
  local changed_fg = get_hl_fg("GitSignsChange") or get_hl_fg("DiffChange") or get_hl_fg("DiagnosticInfo") or 0x5FAFFF

  vim.api.nvim_set_hl(0, defaults.highlight.active, {
    default = true,
    fg = visual.fg or function_fg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, defaults.highlight.inactive, {
    default = true,
    fg = comment_fg,
  })

  vim.api.nvim_set_hl(0, defaults.highlight.icon, {
    default = true,
    fg = function_fg,
  })

  vim.api.nvim_set_hl(0, defaults.highlight.accent, {
    default = true,
    fg = visual.fg or function_fg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, defaults.highlight.modified, {
    default = true,
    fg = get_hl_fg("DiagnosticWarn") or 0xD7AF00,
    bold = true,
  })

  vim.api.nvim_set_hl(0, defaults.highlight.unstaged, {
    default = true,
    fg = changed_fg,
    bold = true,
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

  local function jump_to_line(use_mouse)
    local line = vim.api.nvim_win_get_cursor(0)[1]

    if use_mouse then
      local mouse = vim.fn.getmousepos()
      if mouse and mouse.winid == state.win and mouse.line > 0 then
        line = mouse.line
        pcall(vim.api.nvim_win_set_cursor, state.win, { line, 0 })
      end
    end

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

  vim.keymap.set("n", "<CR>", function()
    jump_to_line(false)
  end, {
    buffer = state.buf,
    nowait = true,
    silent = true,
    desc = "Open selected buffer",
  })

  vim.keymap.set("n", "<LeftMouse>", function()
    jump_to_line(true)
  end, {
    buffer = state.buf,
    nowait = true,
    silent = true,
    desc = "Open clicked buffer",
  })

  vim.keymap.set("n", "<2-LeftMouse>", function()
    jump_to_line(true)
  end, {
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
    "Normal:NormalFloat",
    "EndOfBuffer:EndOfBuffer",
  }, ",")
end

local function add_segment(line, col, text, hl)
  if text == "" then
    return col
  end

  vim.api.nvim_buf_add_highlight(state.buf, state.namespace, hl, line - 1, col, col + #text)
  return col + #text
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
    lines = { " 󰈔 No active buffers" }
  else
    for index, buffer in ipairs(buffers) do
      local marker = buffer.bufnr == active_buf and "▌" or " "
      local name_width = math.max(8, state.opts.width - 4)
      local display_name = truncate_from_left(buffer.display_name or buffer.name, name_width)

      lines[index] = string.format(
        "%s %s %s",
        marker,
        buffer.icon,
        display_name
      )
      state.line_map[index] = buffer.bufnr
      buffer.render_name = display_name
    end
  end

  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(state.buf, state.namespace, 0, -1)

  for line, bufnr in ipairs(state.line_map) do
    local buffer

    for _, item in ipairs(buffers) do
      if item.bufnr == bufnr then
        buffer = item
        break
      end
    end

    if buffer then
      local is_active = bufnr == active_buf
      local line_hl = is_active and state.opts.highlight.active or state.opts.highlight.inactive
      local name_hl = line_hl
      local col = 0

      if buffer.changed then
        name_hl = state.opts.highlight.modified
      elseif buffer.unstaged then
        name_hl = state.opts.highlight.unstaged
      end

      col = add_segment(line, col, is_active and "▌" or " ", state.opts.highlight.accent)
      col = add_segment(line, col, " ", line_hl)
      col = add_segment(line, col, buffer.icon, buffer.icon_hl)
      col = add_segment(line, col, " ", line_hl)
      col = add_segment(
        line,
        col,
        buffer.render_name or buffer.display_name or buffer.name,
        name_hl
      )
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

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = state.augroup,
    callback = function()
      vim.schedule(M.refresh)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = state.augroup,
    pattern = "GitSignsUpdate",
    callback = function()
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
