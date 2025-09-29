vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#BD93F9" })

-- UFO-specific highlights (Dracula colors)
vim.cmd([[
  hi UfoFoldedFg guifg=#6272a4 guibg=NONE
  hi UfoFoldedBg guifg=NONE guibg=#44475a
  highlight Folded ctermfg=61 ctermbg=237
  highlight Folded guifg=#6272a4 guibg=#44475a
]])
