return {
  {
    dir = vim.fn.stdpath("config"),
    name = "active-buffers-sidebar",
    lazy = false,
    config = function()
      require("active_buffers_sidebar").setup({
        position = "left",
        width = 28,
      })
    end,
    keys = {
      {
        "<C-b>",
        function()
          require("active_buffers_sidebar").toggle()
        end,
        desc = "Toggle buffer sidebar",
      },
    },
  },
}
