return {
  "mahadi-jsdev/telescope-marks",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("project_marks").setup()
    require("telescope").load_extension("project_marks")

    vim.keymap.set("n", "<leader>ma", "<cmd>ProjectMarkAdd<cr>", { desc = "Add project mark" })
    vim.keymap.set("n", "<leader>md", "<cmd>ProjectMarkDelete<cr>", { desc = "Delete project mark" })
    vim.keymap.set("n", "<leader>mr", "<cmd>ProjectMarkRename<cr>", { desc = "Rename project mark" })
    vim.keymap.set("n", "<leader>mp", "<cmd>ProjectMarksProject<cr>", { desc = "Project marks" })
    vim.keymap.set("n", "<leader>mf", "<cmd>ProjectMarksBuffer<cr>", { desc = "Buffer marks" })
  end,
}
