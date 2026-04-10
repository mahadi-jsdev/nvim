local markdown_file_types = { "markdown", "opencode_output" }

return {
  "sudo-tee/opencode.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
      opts = {
        anti_conceal = { enabled = false },
        file_types = markdown_file_types,
      },
    },
    "saghen/blink.cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    keymap = {
      editor = {
        ["<C-o>"] = { "toggle" },     -- Toggle opencode panel
        ["<C-p>"] = { "open_input" }, -- Focus input in insert mode
      },
    },
  },
}
