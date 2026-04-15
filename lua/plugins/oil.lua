local M = {}

function M.setup()
  local ok, oil = pcall(require, "oil")
  if not ok then
    return
  end

  oil.setup({
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = false,
    },
  })
end

return M
