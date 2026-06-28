---@type table
local M = {}

M.base46 = {
  theme = "ashes",
  theme_toggle = { "ashes", "one_light" },
  transparency = true,
  integrations = {
    "render-markdown",
  },
}

M.ui = {
  cmp = {
    icons_left = true,
    style = "default", -- default, flat_light, flat_dark, atom, atom_colored
    abbr_maxwidth = 60,
    format_colors = { lsp = true, icon = "󱓻" },
  },

  statusline = {
    enabled = true,
    theme = "default",           -- default, vscode, vscode_colored, minimal
    separator_style = "default", -- default, round, block, arrow
    modules = {
      file = function()
        local utils = require("nvchad.stl.utils")
        local sep_style = require("nvconfig").ui.statusline.separator_style
        local sep = utils.separators[sep_style].right
        local bufnr = utils.stbufnr()
        local status = vim.b[bufnr].gitsigns_status_dict

        if not status or not status.head then
          return "%#St_file# 󰊢 No Git %#St_file_sep#" .. sep
        end

        local added = status.added and status.added > 0 and ("  " .. status.added) or ""
        local changed = status.changed and status.changed > 0 and ("  " .. status.changed) or ""
        local removed = status.removed and status.removed > 0 and ("  " .. status.removed) or ""

        return "%#St_file#  " .. status.head .. added .. changed .. removed .. " %#St_file_sep#" .. sep
      end,

      git = function()
        local utils = require("nvchad.stl.utils")
        local bufnr = utils.stbufnr()
        local path = vim.api.nvim_buf_get_name(bufnr)
        local name = path == "" and "Empty" or vim.fn.fnamemodify(path, ":.")
        local icon = "󰈚"

        if path ~= "" then
          local ok, devicons = pcall(require, "nvim-web-devicons")
          if ok then
            icon = devicons.get_icon(vim.fn.fnamemodify(path, ":t")) or icon
          end
        end

        return "%#St_gitIcons# " .. icon .. " " .. name .. " "
      end,
    },
  },

  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
}

M.nvdash = {
  load_on_startup = false,
  header = {
    "",
    "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "",
  },
  buttons = {
    { txt = "  Find File", keys = "f", cmd = "Telescope find_files" },
    { txt = "󰱼  Find Word", keys = "g", cmd = "Telescope live_grep" },
    { txt = "  Recent Files", keys = "r", cmd = "Telescope oldfiles" },
    { txt = "󱂬  Restore Session", keys = "s", cmd = "lua require('plugins.persistence').restore()" },
    { txt = "  Explorer", keys = "e", cmd = "lua Snacks.explorer()" },
    { txt = "󰏗  Lazy", keys = "l", cmd = "Lazy" },
    { txt = "󰊢  LazyGit", keys = "G", cmd = "LazyGit" },
    { txt = "󱥚  Themes", keys = "t", cmd = "lua require('config.nvchad').open_theme_picker()" },
    { txt = "  Mappings", keys = "m", cmd = "NvCheatsheet" },
    { txt = "  Quit", keys = "q", cmd = "qa" },
  },
}

M.term = {
  startinsert = true,
  base46_colors = true,
  winopts = { number = false, relativenumber = false, signcolumn = "no" },
  sizes = { sp = 0.3, vsp = 0.35, ["bo sp"] = 0.3, ["bo vsp"] = 0.35 },
  float = {
    relative = "editor",
    row = 0.12,
    col = 0.12,
    width = 0.76,
    height = 0.72,
    border = "rounded",
  },
}

M.lsp = {
  signature = true,
}

M.cheatsheet = {
  theme = "grid",
  excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
}

M.mason = {
  pkgs = {
    "stylua",
    "prettierd",
    "prettier",
  },
  skip = {},
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- virtual, fg, bg
  virt_text = "",
  highlight = { hex = true, lspvars = true },
}

return M
