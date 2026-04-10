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
    ui = {
      window_width = 0.50,        -- Width as percentage of editor width
      questions = {
        use_vim_ui_select = true, -- If true, render questions/prompts with vim.ui.select instead of showing them inline in the output buffer.
      },
    }
  },
}
