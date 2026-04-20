local M = {}

function M.setup()
  local markdown_file_types = { "markdown", "opencode_output", "copilot-chat" }
  local opencode_file_types = {
    opencode = true,
    opencode_output = true,
    ["copilot-chat"] = true,
  }

  local function toggle_opencode()
    local api_ok, api = pcall(require, "opencode.api")
    if not api_ok then
      return
    end

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.bo[buf].filetype

    if not opencode_file_types[filetype] then
      local state_ok, state = pcall(require, "opencode.state")
      if state_ok then
        state.ui.set_code_context(win, buf)
        state.ui.set_saved_window_options({
          number = vim.wo[win].number,
          relativenumber = vim.wo[win].relativenumber,
        })
      end
    end

    api.toggle()
  end

  local ok_render_markdown, render_markdown = pcall(require, "render-markdown")
  if ok_render_markdown then
    render_markdown.setup({
      anti_conceal = { enabled = false },
      file_types = markdown_file_types,
    })
  end

  local ok_opencode, opencode = pcall(require, "opencode")
  if not ok_opencode then
    return
  end

  opencode.setup({
    keymap = {
      editor = {
        ["<C-o>"] = { toggle_opencode },
      },
    },
    ui = {
      window_width = 0.30,
      questions = {
        use_vim_ui_select = true,
      },
      position = 'current', -- 'right' (default), 'left' or 'current'. Position of the UI split. 'current' uses the current window for the output.
    },
  })
end

return M
