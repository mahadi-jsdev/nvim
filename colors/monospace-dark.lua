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

	_transparent = "#29364b",
	_yellow = "#fed294",
	_pink = "#c84f66",
}

local function hl(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

local function setup()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "monospace-dark"

	-- Editor
	hl("Normal", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("LineNr", { fg = "#475365" })
	hl("CursorLineNr", { fg = colors.editorForeground, bold = true })
	hl("CursorLine", { bg = colors.editorLineHighlight })
	hl("CursorColumn", { bg = colors.editorLineHighlight })
	hl("Cursor", { fg = colors.editorBackground, bg = colors.editorCursor })
	hl("Visual", { bg = colors._transparent })
	hl("VisualNOS", { bg = colors._transparent })
	hl("Yank", { bg = colors._pink })

	-- UI Elements
	hl("StatusLine", { fg = colors.statuslineForeground, bg = colors.statuslineBackground })
	hl("StatusLineNC", { fg = "#738295", bg = "#10151d" })
	hl("VertSplit", { fg = "#333e4f" })
	hl("FloatBorder", { fg = "#333e4f" })
	hl("NormalFloat", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("FloatTitle", { fg = colors.editorBackground, bg = colors.buttonBackground, bold = true })
	hl("WildMenu", { fg = colors.editorForeground, bg = colors.inputBackground })

	-- Search
	hl("Search", { fg = colors.editorBackground, bg = "#ffa23e" })
	hl("IncSearch", { fg = colors.editorBackground, bg = colors._yellow })

	-- Diagnostics
	hl("DiagnosticError", { fg = colors.errorForeground })
	hl("DiagnosticWarn", { fg = colors.warningForeground })
	hl("DiagnosticInfo", { fg = colors.infForeground })
	hl("DiagnosticHint", { fg = "#66ce98" })
	hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.errorForeground })
	hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warningForeground })
	hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.infForeground })
	hl("DiagnosticUnderlineHint", { undercurl = true, sp = "#66ce98" })

	-- Syntax Highlighting
	hl("Comment", { fg = colors.comment, italic = true })
	hl("String", { fg = colors.string })
	hl("Number", { fg = colors.constant })
	hl("Float", { fg = colors.constant })
	hl("Boolean", { fg = colors.keyword })
	hl("Identifier", { fg = colors.variable })
	hl("Function", { fg = colors.function_name })
	hl("Statement", { fg = colors.keyword })
	hl("Keyword", { fg = colors.keyword })
	hl("Conditional", { fg = colors.keyword })
	hl("Repeat", { fg = colors.keyword })
	hl("Operator", { fg = colors.keyword })
	hl("Type", { fg = colors.constant })
	hl("Structure", { fg = colors.keyword })
	hl("StorageClass", { fg = colors.keyword })
	hl("Special", { fg = colors.keyword })
	hl("SpecialChar", { fg = colors.keyword })
	hl("Tag", { fg = colors.tag })
	hl("Delimiter", { fg = colors.editorForeground })
	hl("Constant", { fg = colors.constant })

	-- Markdown
	hl("markdownH1", { fg = colors.constant, bold = true })
	hl("markdownH2", { fg = colors.constant, bold = true })
	hl("markdownH3", { fg = colors.constant, bold = true })
	hl("markdownHeadingDelimiter", { fg = colors.constant, bold = true })
	hl("markdownBold", { fg = colors.variable, bold = true })
	hl("markdownItalic", { fg = "#85cdf1", italic = true })
	hl("markdownCode", { fg = colors.string })
	hl("markdownCodeBlock", { fg = colors.string })
	hl("markdownLinkText", { fg = colors.string, underline = true })

	-- Treesitter
	hl("@comment", { fg = colors.comment, italic = true })
	hl("@string", { fg = colors.string })
	hl("@string.documentation", { fg = colors.comment, italic = true })
	hl("@number", { fg = colors.constant })
	hl("@boolean", { fg = colors.keyword })
	hl("@variable", { fg = colors.editorForeground })
	hl("@variable.builtin", { fg = colors.keyword })
	hl("@variable.parameter", { fg = colors.editorForeground })
	hl("@function", { fg = colors.function_name })
	hl("@function.builtin", { fg = colors.constant })
	hl("@function.call", { fg = colors.function_name })
	hl("@method", { fg = colors.function_name })
	hl("@method.call", { fg = colors.function_name })
	hl("@keyword", { fg = colors.keyword })
	hl("@keyword.function", { fg = colors.keyword })
	hl("@keyword.operator", { fg = colors.keyword })
	hl("@operator", { fg = colors.keyword })
	hl("@type", { fg = colors.constant })
	hl("@type.builtin", { fg = colors.constant })
	hl("@structure", { fg = colors.constant })
	hl("@tag", { fg = colors.tag })
	hl("@tag.attribute", { fg = colors.stringHtml })
	hl("@tag.delimiter", { fg = colors.tag })
	hl("@markup.heading", { fg = colors.constant, bold = true })
	hl("@markup.italic", { italic = true })
	hl("@markup.bold", { bold = true })
	hl("@markup.strikethrough", { strikethrough = true })
	hl("@markup.link", { fg = colors.link, underline = true })
	hl("@markup.link.url", { fg = colors.link, underline = true })
	hl("@markup.raw", { fg = colors.string })
	hl("@markup.list", { fg = colors.keyword })
	hl("@punctuation", { fg = colors.editorForeground })
	hl("@punctuation.bracket", { fg = colors.editorForeground })
	hl("@punctuation.delimiter", { fg = colors.editorForeground })

	-- LSP
	hl("LspReferenceText", { bg = "#333e4f" })
	hl("LspReferenceRead", { bg = "#333e4f" })
	hl("LspReferenceWrite", { bg = "#333e4f" })

	-- Completion Menu
	hl("Pmenu", { fg = colors.editorForeground, bg = colors.dropdownBackground })
	hl("PmenuSel", { fg = colors.editorForeground, bg = colors.inputBackground, bold = true })
	hl("PmenuSbar", { bg = colors.dropdownBackground })
	hl("PmenuThumb", { bg = colors.editorLineHighlight })

	-- Diff
	hl("DiffAdd", { fg = colors.diffAdded, bg = "#001f12" })
	hl("DiffDelete", { fg = colors.diffRemoved, bg = "#220012" })
	hl("DiffChange", { fg = colors.diffModified, bg = "#001a33" })
	hl("DiffText", { fg = colors.diffModified, bg = "#003d66" })

	-- Snacks.nvim support
	-- Notifier
	hl("SnacksNotifierBorder", { fg = "#333e4f" })
	hl("SnacksNotifierTitleError", { fg = colors.errorForeground, bg = colors.editorBackground, bold = true })
	hl("SnacksNotifierTitleWarn", { fg = colors.warningForeground, bg = colors.editorBackground, bold = true })
	hl("SnacksNotifierTitleInfo", { fg = colors.infForeground, bg = colors.editorBackground, bold = true })
	hl("SnacksNotifierTitleDebug", { fg = "#71c2ee", bg = colors.editorBackground, bold = true })
	hl("SnacksNotifierBodyError", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksNotifierBodyWarn", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksNotifierBodyInfo", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksNotifierBodyDebug", { fg = colors.editorForeground, bg = colors.editorBackground })

	-- Dashboard
	hl("SnacksDashboardHeader", { fg = colors.buttonBackground, bold = true })
	hl("SnacksDashboardFooter", { fg = colors.comment })
	hl("SnacksDashboardKey", { fg = colors.constant })
	hl("SnacksDashboardDesc", { fg = colors.editorForeground })
	hl("SnacksDashboardIcon", { fg = colors.variable })
	hl("SnacksDashboardTitle", { fg = colors.buttonBackground, bold = true })

	-- Picker (fuzzy finder)
	hl("SnacksPickerBorder", { fg = "#333e4f" })
	hl("SnacksPickerNormal", { fg = colors.editorForeground, bg = "#10151d" })
	hl("SnacksPickerTitle", { fg = colors.editorBackground, bg = colors.buttonBackground, bold = true })
	hl("SnacksPickerPrompt", { fg = colors.editorForeground, bg = "#171f2b" })
	hl("SnacksPickerInput", { fg = colors.editorForeground, bg = "#171f2b" })
	hl("SnacksPickerList", { fg = colors.editorForeground, bg = "#171f2b" })
	hl("SnacksPickerItem", { fg = colors.editorForeground })
	hl("SnacksPickerSelected", { bg = colors.selectionBackground, bold = true })
	hl("SnacksPickerMatch", { fg = nil, bold = true })
	hl("SnacksPickerDir", { fg = colors.constant })
	hl("SnacksPickerFile", { fg = colors.editorForeground })
	hl("SnacksPickerPreview", { fg = colors.editorForeground, bg = "#171f2b" })
	hl("SnacksPickerSelected", { fg = colors._pink, bg = colors.editorBackground })

	-- Snacks explorer highlight groups
	hl("SnacksIndent", { fg = colors.comment })
	hl("SnacksIndentScope", { fg = colors.focusBorder })

	-- File explorer specific highlights
	hl("SnacksNotifierIconTrace", { fg = colors.magenta })
	hl("SnacksNotifierIconDebug", { fg = colors.comment })
	hl("SnacksNotifierIconInfo", { fg = colors.infForeground })
	hl("SnacksNotifierIconWarn", { fg = colors.warningForeground })
	hl("SnacksNotifierIconError", { fg = colors.errorForeground })

	-- Directory and file highlights
	hl("SnacksIndent", { fg = colors.comment })
	hl("SnacksIndentScope", { fg = colors.focusBorder })

	-- Explorer window
	hl("SnacksNotifierBorderTrace", { fg = colors.magenta })
	hl("SnacksNotifierBorderDebug", { fg = colors.comment })
	hl("SnacksNotifierBorderInfo", { fg = colors.infForeground })
	hl("SnacksNotifierBorderWarn", { fg = colors.warningForeground })
	hl("SnacksNotifierBorderError", { fg = colors.errorForeground })

	-- Additional explorer colors
	hl("Directory", { fg = colors.blue })
	hl("SpecialKey", { fg = colors.comment })

	-- Input
	hl("SnacksInputBorder", { fg = "#333e4f" })
	hl("SnacksInputNormal", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksInputTitle", { fg = colors.editorBackground, bg = colors.buttonBackground, bold = true })
	hl("SnacksInputPrompt", { fg = colors.editorForeground, bg = colors.editorBackground })

	-- Indent
	hl("SnacksIndent", { fg = "#333e4f" })
	hl("SnacksIndentScope", { fg = colors.buttonBackground })

	-- Scope
	hl("SnacksScopeBorder", { fg = "#333e4f" })
	hl("SnacksScopeNormal", { fg = colors.editorForeground, bg = "#10151d" })

	-- Status Column
	hl("SnacksStatusColumnFold", { fg = "#475365" })
	hl("SnacksStatusColumnSign", { fg = "#475365" })

	-- BuffDelete (undouble)
	hl("SnacksBuffDeleteBorder", { fg = "#333e4f" })
	hl("SnacksBuffDeleteNormal", { fg = colors.editorForeground, bg = colors.editorBackground })

	-- LSP Input/Rename
	hl("SnacksLspInputBorder", { fg = "#333e4f" })
	hl("SnacksLspInputNormal", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksLspInputTitle", { fg = colors.editorBackground, bg = colors.buttonBackground, bold = true })
	hl("SnacksLspInputPrompt", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksLspRenameBorder", { fg = "#333e4f" })
	hl("SnacksLspRenameNormal", { fg = colors.editorForeground, bg = colors.editorBackground })
	hl("SnacksLspRenameTitle", { fg = colors.editorBackground, bg = colors.buttonBackground, bold = true })
	hl("SnacksLspRenamePrompt", { fg = colors.editorForeground, bg = colors.editorBackground })

	-- Yazi.nvim support
	hl("YaziHeader", { fg = colors.constant, bold = true })
	hl("YaziDirHighlight", { fg = colors.constant })
	hl("YaziFileHighlight", { fg = colors.editorForeground })
	hl("YaziSymlinkHighlight", { fg = colors.link })
	hl("YaziExecutableHighlight", { fg = colors.string })
	hl("YaziSelectedHighlight", { bg = colors.selectionBackground })
	hl("YaziHoverHighlight", { bg = colors.editorLineHighlight })

	-- Gitsigns support
	hl("GitSignsAdd", { fg = colors.diffAdded })
	hl("GitSignsChange", { fg = colors.diffModified })
	hl("GitSignsDelete", { fg = colors.diffRemoved })
	hl("GitSignsAddNr", { fg = colors.diffAdded })
	hl("GitSignsChangeNr", { fg = colors.diffModified })
	hl("GitSignsDeleteNr", { fg = colors.diffRemoved })
	hl("GitSignsAddLn", { bg = "#001f12" })
	hl("GitSignsChangeLn", { bg = "#001a33" })
	hl("GitSignsDeleteLn", { bg = "#220012" })

	-- Blink.cmp support
	hl("BlinkCmpMenu", { fg = colors.editorForeground, bg = colors.dropdownBackground })
	hl("BlinkCmpMenuBorder", { fg = "#333e4f" })
	hl("BlinkCmpMenuSelection", { fg = colors.editorForeground, bg = colors._pink, bold = true })
	hl("BlinkCmpMenuItem", { fg = colors.editorForeground })
	hl("BlinkCmpMenuScrollbar", { bg = colors.editorLineHighlight })
	hl("BlinkCmpMenuThumb", { bg = colors.statuslineForeground })
	hl("BlinkCmpDocBorder", { fg = "#333e4f" })
	hl("BlinkCmpDocNormal", { fg = colors.editorForeground, bg = "#10151d" })
	hl("BlinkCmpSignatureHint", { fg = colors.editorForeground })
	hl("BlinkCmpSignatureLabel", { fg = colors.editorForeground })

	-- Blink.cmp Kind highlights (completion item types)
	hl("BlinkCmpKind", { fg = colors.editorForeground })
	hl("BlinkCmpKindText", { fg = colors.string })
	hl("BlinkCmpKindMethod", { fg = colors.function_name })
	hl("BlinkCmpKindFunction", { fg = colors.function_name })
	hl("BlinkCmpKindConstructor", { fg = colors.function_name })
	hl("BlinkCmpKindField", { fg = colors.variable })
	hl("BlinkCmpKindVariable", { fg = colors.variable })
	hl("BlinkCmpKindClass", { fg = colors.constant })
	hl("BlinkCmpKindInterface", { fg = colors.constant })
	hl("BlinkCmpKindModule", { fg = colors.constant })
	hl("BlinkCmpKindProperty", { fg = colors.variable })
	hl("BlinkCmpKindUnit", { fg = colors.constant })
	hl("BlinkCmpKindValue", { fg = colors.constant })
	hl("BlinkCmpKindEnum", { fg = colors.constant })
	hl("BlinkCmpKindKeyword", { fg = colors.keyword })
	hl("BlinkCmpKindSnippet", { fg = colors.string })
	hl("BlinkCmpKindColor", { fg = colors.variable })
	hl("BlinkCmpKindFile", { fg = colors.editorForeground })
	hl("BlinkCmpKindReference", { fg = colors.editorForeground })
	hl("BlinkCmpKindFolder", { fg = colors.constant })
	hl("BlinkCmpKindEnumMember", { fg = colors.variable })
	hl("BlinkCmpKindConstant", { fg = colors.constant })
	hl("BlinkCmpKindStruct", { fg = colors.constant })
	hl("BlinkCmpKindEvent", { fg = colors.constant })
	hl("BlinkCmpKindOperator", { fg = colors.keyword })
	hl("BlinkCmpKindTypeParameter", { fg = colors.constant })
	hl("BlinkCmpKindCopilot", { fg = colors.buttonBackground })
	hl("BlinkCmpKindDefault", { fg = colors.editorForeground })

	-- Quickfix colors
	hl("qfFileName", { fg = colors.constant })
	hl("qfLineNr", { fg = colors.comment })
	hl("qfError", { fg = colors.errorForeground, bold = true })
	hl("qfWarning", { fg = colors.warningForeground })
	hl("qfInfo", { fg = colors.infForeground })
	hl("QuickFixLine", { bg = colors._transparent, bold = true })
	hl("qfSeparator", { fg = colors.comment })

	-- MiniStatusline Mode highlights
	hl("MiniStatuslineModeNormal", { fg = colors.editorBackground, bg = colors.constant, bold = true })
	hl("MiniStatuslineModeInsert", { fg = colors.editorBackground, bg = colors.string, bold = true })
	hl("MiniStatuslineModeVisual", { fg = colors.editorBackground, bg = colors.magenta, bold = true })
	hl("MiniStatuslineModeReplace", { fg = colors.editorBackground, bg = colors.errorForeground, bold = true })
	hl("MiniStatuslineModeCommand", { fg = colors.editorBackground, bg = colors.variable, bold = true })
	hl("MiniStatuslineModeOther", { fg = colors.editorBackground, bg = colors.cyan, bold = true })

	-- MiniStatusline Section highlights
	hl("MiniStatuslineDevinfo", { fg = colors.statuslineForeground, bg = colors.statuslineBackground })
	hl("MiniStatuslineFilename", { fg = colors.foreground, bg = colors.statuslineBackground, bold = true })
	hl("MiniStatuslineFileinfo", { fg = colors.statuslineForeground, bg = colors.statuslineBackground })
	hl("MiniStatuslineInactive", { fg = colors.comment, bg = colors.editorBackground })

	-- MiniTabline highlights
	hl("MiniTablineCurrent", { fg = colors.foreground, bg = colors.editorLineHighlight, bold = true })
	hl("MiniTablineVisible", { fg = colors.statuslineForeground, bg = colors.statuslineBackground })
	hl("MiniTablineHidden", { fg = colors.comment, bg = colors.editorBackground })
	hl("MiniTablineModifiedCurrent", { fg = colors.diffModified, bg = colors.editorLineHighlight, bold = true })
	hl("MiniTablineModifiedVisible", { fg = colors.diffModified, bg = colors.statuslineBackground })
	hl("MiniTablineModifiedHidden", { fg = colors.comment, bg = colors.editorBackground, italic = true })
	hl("MiniTablineFill", { bg = colors.statuslineBackground })
	hl("MiniTablineTabpagesection", { fg = colors.editorBackground, bg = colors.magenta, bold = true })
	hl("MiniTablineTrunc", { fg = colors.warningForeground, bg = colors.editorBackground, bold = true })

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

	-- UFO-specific highlights (Monospace Dark theme)
	hl("UfoFoldedFg", { fg = "#7f8d9f" })
	hl("UfoFoldedBg", { bg = "#1f2939" })
	hl("Folded", { fg = "#7f8d9f", bg = colors._transparent })
end

-- Initialize the color scheme
setup()

return M
