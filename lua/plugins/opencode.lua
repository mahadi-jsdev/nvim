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
      input = {
        min_height = 0.15, -- min height of prompt input as percentage of window height
        max_height = 0.30, -- max height of prompt input as percentage of window height
        text = {
          wrap = false,    -- Wraps text inside input window
        },
        -- Auto-hide input window when prompt is submitted or focus switches to output window
        auto_hide = false,
      },
    }
  },
}
