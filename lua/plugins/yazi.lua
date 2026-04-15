local M = {}

function M.setup()
  local ok, yazi = pcall(require, "yazi")
  if not ok then
    return
  end

  yazi.setup({
    open_for_directories = false,
  })
end

return M
