return {
  "kdheepak/lazygit.nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "LazyGit" }) -- file tree
  end
}
