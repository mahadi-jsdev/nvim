local M = {}

function M.setup()
  local ok, indent = pcall(require, "blink.indent")
  if not ok then
    return
  end

  indent.setup({
    static = {
      enabled = true,
      char = "│",
    },
    scope = {
      enabled = true,
      char = "│",
    },
  })
end

return M
