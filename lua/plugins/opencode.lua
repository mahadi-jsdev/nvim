local M = {}

function M.setup()
  local markdown_file_types = { "markdown", "opencode_output", "copilot-chat" }

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
        ["<C-o>"] = { "toggle" },
      },
    },
    ui = {
      window_width = 0.50,
      questions = {
        use_vim_ui_select = true,
      },
    },
  })
end

return M
