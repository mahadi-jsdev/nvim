-- Monospace Dark Theme for Neovim
-- Ported from VSCode theme

local M = {}

local colors = {
	-- Base colors
	foreground = "#d9dfe7",
	background = "#171f2b",

	-- UI colors
	focusBorder = "#8964e8",
	errorForeground = "#f76769",
	warningForeground = "#ffb256",
	infForeground = "#a2b6ff",

	-- Link colors
	link = "#b895fd",
	linkActive = "#c8aaffff",

	-- Editor colors
	editorBackground = "#171f2b",
	editorForeground = "#d9dfe7",
	editorLineHighlight = "#1f2939",
	editorCursor = "#e0ccff",

	-- Sidebar
	sidebarBackground = "#10151d",
	sidebarForeground = "#d9dfe7",

	-- Statusline
	statuslineBackground = "#1f2939",
	statuslineForeground = "#a4afbd",

	-- Syntax colors
	comment = "#7f8d9f",
	constant = "#92a9ff",
	string = "#77d5a3",
	stringHtml = "#85cdf1",
	keyword = "#fd8da3",
	function_name = "#bd9cfe",
	variable = "#ffd395",
	tag = "#77d5a3",

	-- Diff colors
	diffAdded = "#17b877",
	diffRemoved = "#f76769",
	diffModified = "#708fff",
	diffConflict = "#ffc26e",

	-- UI element backgrounds
	buttonBackground = "#a87ffb",
	buttonHoverBackground = "#b895fd",
	inputBackground = "#1f2939",
	dropdownBackground = "#1f2939",

	-- Highlight colors
	selectionBackground = "#264dcb",
	inactiveSelectionBackground = "#264dcb",
	matchBackground = "#834314",

	-- Terminal colors
	black = "#738295",
	red = "#f76769",
	green = "#17b877",
	yellow = "#ffa23e",
	blue = "#708fff",
	magenta = "#a87ffb",
	cyan = "#25a6e9",
	white = "#a4afbd",

	brightBlack = "#8b98a9",
	brightRed = "#fc8f8e",
	brightGreen = "#66ce98",
	brightYellow = "#ffc26e",
	brightBlue = "#a2b6ff",
	brightMagenta = "#c8aaff",
	brightCyan = "#71c2ee",
	brightWhite = "#fafbfe",
}

function M.setup()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "monospace-dark"

	-- Editor
	M.hl("Normal", { fg = colors.editorForeground, bg = colors.editorBackground })
	M.hl("LineNr", { fg = "#475365" })
	M.hl("CursorLineNr", { fg = colors.editorForeground, bold = true })
	M.hl("CursorLine", { bg = colors.editorLineHighlight })
	M.hl("CursorColumn", { bg = colors.editorLineHighlight })
	M.hl("Cursor", { fg = colors.editorBackground, bg = colors.editorCursor })
	M.hl("Visual", { bg = colors.selectionBackground })
	M.hl("VisualNOS", { bg = colors.inactiveSelectionBackground })

	-- UI Elements
	M.hl("StatusLine", { fg = colors.statuslineForeground, bg = colors.statuslineBackground })
	M.hl("StatusLineNC", { fg = "#738295", bg = "#10151d" })
	M.hl("VertSplit", { fg = "#333e4f" })
	M.hl("FloatBorder", { fg = "#333e4f" })
	M.hl("NormalFloat", { fg = colors.editorForeground, bg = "#10151d" })
	M.hl("WildMenu", { fg = colors.editorForeground, bg = colors.inputBackground })

	-- Sidebar/File explorer
	M.hl("NvimTreeFolderName", { fg = colors.sidebarForeground })
	M.hl("NvimTreeFolderIcon", { fg = colors.constant })
	M.hl("NvimTreeFileIcon", { fg = colors.constant })
	M.hl("NvimTreeNormal", { fg = colors.sidebarForeground, bg = colors.sidebarBackground })

	-- Search
	M.hl("Search", { fg = colors.editorBackground, bg = "#ffa23e" })
	M.hl("IncSearch", { fg = colors.editorBackground, bg = colors.matchBackground })

	-- Diagnostics
	M.hl("DiagnosticError", { fg = colors.errorForeground })
	M.hl("DiagnosticWarn", { fg = colors.warningForeground })
	M.hl("DiagnosticInfo", { fg = colors.infForeground })
	M.hl("DiagnosticHint", { fg = "#66ce98" })
	M.hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.errorForeground })
	M.hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warningForeground })
	M.hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.infForeground })
	M.hl("DiagnosticUnderlineHint", { undercurl = true, sp = "#66ce98" })

	-- Syntax Highlighting
	M.hl("Comment", { fg = colors.comment, italic = true })
	M.hl("String", { fg = colors.string })
	M.hl("Number", { fg = colors.constant })
	M.hl("Float", { fg = colors.constant })
	M.hl("Boolean", { fg = colors.keyword })
	M.hl("Identifier", { fg = colors.variable })
	M.hl("Function", { fg = colors.function_name })
	M.hl("Statement", { fg = colors.keyword })
	M.hl("Keyword", { fg = colors.keyword })
	M.hl("Conditional", { fg = colors.keyword })
	M.hl("Repeat", { fg = colors.keyword })
	M.hl("Operator", { fg = colors.keyword })
	M.hl("Type", { fg = colors.constant })
	M.hl("Structure", { fg = colors.keyword })
	M.hl("StorageClass", { fg = colors.keyword })
	M.hl("Special", { fg = colors.keyword })
	M.hl("SpecialChar", { fg = colors.keyword })
	M.hl("Tag", { fg = colors.tag })
	M.hl("Delimiter", { fg = colors.editorForeground })
	M.hl("Constant", { fg = colors.constant })

	-- Markdown
	M.hl("markdownH1", { fg = colors.constant, bold = true })
	M.hl("markdownH2", { fg = colors.constant, bold = true })
	M.hl("markdownH3", { fg = colors.constant, bold = true })
	M.hl("markdownHeadingDelimiter", { fg = colors.constant, bold = true })
	M.hl("markdownBold", { fg = colors.variable, bold = true })
	M.hl("markdownItalic", { fg = "#85cdf1", italic = true })
	M.hl("markdownCode", { fg = colors.string })
	M.hl("markdownCodeBlock", { fg = colors.string })
	M.hl("markdownLinkText", { fg = colors.string, underline = true })

	-- Treesitter
	M.hl("@comment", { fg = colors.comment, italic = true })
	M.hl("@string", { fg = colors.string })
	M.hl("@string.documentation", { fg = colors.comment, italic = true })
	M.hl("@number", { fg = colors.constant })
	M.hl("@boolean", { fg = colors.keyword })
	M.hl("@variable", { fg = colors.editorForeground })
	M.hl("@variable.builtin", { fg = colors.keyword })
	M.hl("@variable.parameter", { fg = colors.editorForeground })
	M.hl("@function", { fg = colors.function_name })
	M.hl("@function.builtin", { fg = colors.constant })
	M.hl("@function.call", { fg = colors.function_name })
	M.hl("@method", { fg = colors.function_name })
	M.hl("@method.call", { fg = colors.function_name })
	M.hl("@keyword", { fg = colors.keyword })
	M.hl("@keyword.function", { fg = colors.keyword })
	M.hl("@keyword.operator", { fg = colors.keyword })
	M.hl("@operator", { fg = colors.keyword })
	M.hl("@type", { fg = colors.constant })
	M.hl("@type.builtin", { fg = colors.constant })
	M.hl("@structure", { fg = colors.constant })
	M.hl("@tag", { fg = colors.tag })
	M.hl("@tag.attribute", { fg = colors.stringHtml })
	M.hl("@tag.delimiter", { fg = colors.tag })
	M.hl("@markup.heading", { fg = colors.constant, bold = true })
	M.hl("@markup.italic", { italic = true })
	M.hl("@markup.bold", { bold = true })
	M.hl("@markup.strikethrough", { strikethrough = true })
	M.hl("@markup.link", { fg = colors.link, underline = true })
	M.hl("@markup.link.url", { fg = colors.link, underline = true })
	M.hl("@markup.raw", { fg = colors.string })
	M.hl("@markup.list", { fg = colors.keyword })
	M.hl("@punctuation", { fg = colors.editorForeground })
	M.hl("@punctuation.bracket", { fg = colors.editorForeground })
	M.hl("@punctuation.delimiter", { fg = colors.editorForeground })

	-- LSP
	M.hl("LspReferenceText", { bg = "#333e4f" })
	M.hl("LspReferenceRead", { bg = "#333e4f" })
	M.hl("LspReferenceWrite", { bg = "#333e4f" })

	-- Completion Menu
	M.hl("Pmenu", { fg = colors.editorForeground, bg = colors.dropdownBackground })
	M.hl("PmenuSel", { fg = colors.editorForeground, bg = colors.inputBackground, bold = true })
	M.hl("PmenuSbar", { bg = colors.dropdownBackground })
	M.hl("PmenuThumb", { bg = colors.editorLineHighlight })

	-- Diff
	M.hl("DiffAdd", { fg = colors.diffAdded, bg = "#001f12" })
	M.hl("DiffDelete", { fg = colors.diffRemoved, bg = "#220012" })
	M.hl("DiffChange", { fg = colors.diffModified, bg = "#001a33" })
	M.hl("DiffText", { fg = colors.diffModified, bg = "#003d66" })

	-- Spell
	M.hl("SpellBad", { undercurl = true, sp = colors.errorForeground })
	M.hl("SpellCap", { undercurl = true, sp = colors.warningForeground })
	M.hl("SpellLocal", { undercurl = true, sp = colors.infForeground })
	M.hl("SpellRare", { undercurl = true, sp = colors.infForeground })

	-- Terminal mode colors
	vim.g.terminal_color_0 = colors.black
	vim.g.terminal_color_1 = colors.red
	vim.g.terminal_color_2 = colors.green
	vim.g.terminal_color_3 = colors.yellow
	vim.g.terminal_color_4 = colors.blue
	vim.g.terminal_color_5 = colors.magenta
	vim.g.terminal_color_6 = colors.cyan
	vim.g.terminal_color_7 = colors.white
	vim.g.terminal_color_8 = colors.brightBlack
	vim.g.terminal_color_9 = colors.brightRed
	vim.g.terminal_color_10 = colors.brightGreen
	vim.g.terminal_color_11 = colors.brightYellow
	vim.g.terminal_color_12 = colors.brightBlue
	vim.g.terminal_color_13 = colors.brightMagenta
	vim.g.terminal_color_14 = colors.brightCyan
	vim.g.terminal_color_15 = colors.brightWhite
end

function M.hl(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

M.setup()

return M
