local M = {}

function M.setup()
  vim.g.gruvbox_material_background = "hard"
  vim.g.gruvbox_material_foreground = "material"
  vim.cmd.colorscheme("gruvbox-material")
end

return M
