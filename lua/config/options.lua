local opt = vim.opt
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Settings
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.winborder = "rounded"
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.fillchars = { eob = " " }
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autoread = true
opt.conceallevel = 2
vim.g.loaded_netrwPlugin = 1

-- Tte 'leader' key is usually Space or Backslash
vim.keymap.set('n', '<leader>tw', function()
  -- Check if wrap is currently on
  local is_on = vim.opt.wrap:get()

  if is_on then
    vim.opt.wrap = false
    vim.opt.linebreak = false
    vim.opt.breakindent = false
    print("Tailwind Wrap: OFF")
  else
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.breakindent = true
    print("Tailwind Wrap: ON")
  end
end, { desc = "Toggle Tailwind Friendly Wrap" })


-- Diagnostics appearance
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})
