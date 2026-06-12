-- jetbrains-dark — colorscheme based on JetBrains New UI "Dark" theme
local M = {}

-- palette from IntelliJ IDEA New UI Dark defaults
local p = {
	--bg          = "#17181B", -- editor background
	bg          = "#111111", -- editor background
	bg_alt      = "#222222", -- panels, popups
	bg_dim      = "#1F2024", -- caret row
	fg          = "#BCBEC4", -- default text
	fg_dim      = "#868A91",
	gray        = "#7A7E85", -- comments
	line_nr     = "#4B5059",
	border      = "#2F3134",
	selection   = "#2B3245", -- muted blue-gray; old IDEA blue: #214283
	search      = "#114957",
	search_cur  = "#155221",

	orange      = "#CF8E6D", -- keywords
	blue        = "#56A8F5", -- functions / methods
	green       = "#6AAB73", -- strings
	teal        = "#2AACB8", -- numbers
	purple      = "#C77DBB", -- fields / constants / builtins
	yellow      = "#B3AE60", -- annotations / metadata
	tag         = "#D5B778", -- HTML/XML tag names (IDEA gold-tan)
	doc_green   = "#5F826B", -- doc comments
	cyan        = "#42C3D4",

	error       = "#F75464",
	warning     = "#F2C55C",
	info        = "#548AF7",
	hint        = "#787878",

	diff_add    = "#294436",
	diff_change = "#385570",
	diff_delete = "#45302B",
	git_add     = "#549159",
	git_change  = "#375FAD",
	git_delete  = "#868A91",
}

function M.load()
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "jetbrains-dark"

	local hl = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- ── UI ──────────────────────────────────────────────
	hl("Normal",        { fg = p.fg, bg = p.bg })
	hl("NormalNC",      { fg = p.fg, bg = p.bg })
	hl("NormalFloat",   { fg = p.fg, bg = p.bg_alt })
	hl("FloatBorder",   { fg = p.border, bg = p.bg_alt })
	hl("FloatTitle",    { fg = p.fg, bg = p.bg_alt, bold = true })
	hl("CursorLine",    { bg = p.bg_dim })
	hl("CursorColumn",  { bg = p.bg_dim })
	hl("ColorColumn",   { bg = p.bg_dim })
	hl("LineNr",        { fg = p.line_nr })
	hl("CursorLineNr",  { fg = p.fg })
	hl("SignColumn",    { bg = p.bg })
	hl("Visual",        { bg = p.selection })
	hl("VisualNOS",     { bg = p.selection })
	hl("Search",        { bg = p.search })
	hl("IncSearch",     { bg = p.search_cur })
	hl("CurSearch",     { bg = p.search_cur })
	hl("MatchParen",    { bg = p.border, bold = true })
	hl("StatusLine",    { fg = p.fg, bg = p.bg_alt })
	hl("StatusLineNC",  { fg = p.fg_dim, bg = p.bg_alt })
	hl("WinSeparator",  { fg = p.border })
	hl("VertSplit",     { fg = p.border })
	hl("TabLine",       { fg = p.fg_dim, bg = p.bg_alt })
	hl("TabLineSel",    { fg = p.fg, bg = p.bg, bold = true })
	hl("TabLineFill",   { bg = p.bg_alt })
	hl("Pmenu",         { fg = p.fg, bg = p.bg_alt })
	hl("PmenuSel",      { bg = p.selection })
	hl("PmenuSbar",     { bg = p.bg_alt })
	hl("PmenuThumb",    { bg = p.border })
	hl("WildMenu",      { bg = p.selection })
	hl("Folded",        { fg = p.fg_dim, bg = p.bg_dim })
	hl("FoldColumn",    { fg = p.line_nr, bg = p.bg })
	hl("NonText",       { fg = p.line_nr })
	hl("Whitespace",    { fg = p.line_nr })
	hl("SpecialKey",    { fg = p.line_nr })
	hl("EndOfBuffer",   { fg = p.bg })
	hl("Directory",     { fg = p.blue })
	hl("Title",         { fg = p.fg, bold = true })
	hl("ErrorMsg",      { fg = p.error })
	hl("WarningMsg",    { fg = p.warning })
	hl("MoreMsg",       { fg = p.green })
	hl("Question",      { fg = p.blue })
	hl("QuickFixLine",  { bg = p.bg_dim })

	-- ── syntax (classic groups) ─────────────────────────
	hl("Comment",       { fg = p.gray, italic = true })
	hl("String",        { fg = p.green })
	hl("Character",     { fg = p.green })
	hl("Number",        { fg = p.teal })
	hl("Float",         { fg = p.teal })
	hl("Boolean",       { fg = p.orange })
	hl("Constant",      { fg = p.purple, italic = true })
	hl("Identifier",    { fg = p.fg })
	hl("Function",      { fg = p.blue })
	hl("Statement",     { fg = p.orange })
	hl("Keyword",       { fg = p.orange })
	hl("Conditional",   { fg = p.orange })
	hl("Repeat",        { fg = p.orange })
	hl("Label",         { fg = p.orange })
	hl("Operator",      { fg = p.fg })
	hl("Exception",     { fg = p.orange })
	hl("PreProc",       { fg = p.yellow })
	hl("Include",       { fg = p.orange })
	hl("Define",        { fg = p.orange })
	hl("Macro",         { fg = p.yellow })
	hl("Type",          { fg = p.fg })
	hl("StorageClass",  { fg = p.orange })
	hl("Structure",     { fg = p.orange })
	hl("Typedef",       { fg = p.orange })
	hl("Special",       { fg = p.orange })
	hl("SpecialChar",   { fg = p.orange })
	hl("Tag",           { fg = p.tag })
	hl("Delimiter",     { fg = p.fg })
	hl("SpecialComment",{ fg = p.doc_green })
	hl("Todo",          { fg = p.yellow, bg = "NONE", bold = true, italic = true })
	hl("Error",         { fg = p.error })
	hl("Underlined",    { fg = p.blue, underline = true })

	-- ── treesitter ──────────────────────────────────────
	hl("@variable",            { fg = p.fg })
	hl("@variable.builtin",    { fg = p.purple })
	hl("@variable.member",     { fg = p.purple }) -- fields, like IDEA instance fields
	hl("@variable.parameter",  { fg = p.fg })
	hl("@constant",            { link = "Constant" })
	hl("@constant.builtin",    { fg = p.orange })
	hl("@constant.macro",      { fg = p.yellow })
	hl("@module",              { fg = p.fg })
	hl("@label",               { fg = p.orange })
	hl("@string",              { link = "String" })
	hl("@string.escape",       { fg = p.orange })
	hl("@string.regexp",       { fg = p.teal })
	hl("@string.special.url",  { fg = p.blue, underline = true })
	hl("@character",           { link = "Character" })
	hl("@number",              { link = "Number" })
	hl("@boolean",             { link = "Boolean" })
	hl("@function",            { link = "Function" })
	hl("@function.builtin",    { fg = p.blue })
	hl("@function.call",       { fg = p.blue })
	hl("@function.macro",      { fg = p.yellow })
	hl("@function.method",     { fg = p.blue })
	hl("@function.method.call",{ fg = p.blue })
	hl("@constructor",         { fg = p.fg })
	hl("@operator",            { link = "Operator" })
	hl("@keyword",             { link = "Keyword" })
	hl("@keyword.function",    { fg = p.orange })
	hl("@keyword.return",      { fg = p.orange })
	hl("@keyword.import",      { fg = p.orange })
	hl("@punctuation.bracket",     { fg = p.fg })
	hl("@punctuation.delimiter",   { fg = p.fg })
	hl("@punctuation.special",     { fg = p.orange })
	hl("@comment",                 { link = "Comment" })
	hl("@comment.documentation",   { fg = p.doc_green })
	hl("@comment.todo",            { link = "Todo" })
	hl("@comment.error",           { fg = p.error, bold = true })
	hl("@comment.warning",         { fg = p.warning, bold = true })
	hl("@type",                { link = "Type" })
	hl("@type.builtin",        { fg = p.orange })
	hl("@type.definition",     { fg = p.fg })
	hl("@attribute",           { fg = p.yellow }) -- annotations/decorators
	hl("@property",            { fg = p.purple })
	hl("@tag",                 { fg = p.tag })
	hl("@tag.builtin",         { fg = p.tag })
	hl("@tag.attribute",       { fg = p.fg })
	hl("@tag.delimiter",       { fg = p.fg_dim })
	hl("@markup.heading",           { fg = p.blue, bold = true })
	hl("@markup.heading.1",         { fg = p.blue, bold = true })
	hl("@markup.heading.2",         { fg = p.orange, bold = true })
	hl("@markup.heading.3",         { fg = p.yellow,   bold = true })
	hl("@markup.heading.4",         { fg = p.green,  bold = true })
	hl("@markup.heading.marker",    { fg = p.fg_dim })
	hl("@markup.quote",             { fg = p.fg_dim, italic = true })
	hl("@markup.strong",            { bold = true })
	hl("@markup.italic",            { italic = true })
	hl("@markup.strikethrough",     { strikethrough = true })
	hl("@markup.link",              { fg = p.blue })
	hl("@markup.link.url",          { fg = p.blue, underline = true })
	hl("@markup.raw",               { fg = p.green })
	hl("@markup.list",              { fg = p.orange })
	hl("@markup.list.checked",      { fg = p.green })
	hl("@markup.list.unchecked",    { fg = p.fg_dim })

	-- ── LSP semantic tokens (match IDEA semantics) ──────
	hl("@lsp.type.class",         { fg = p.fg })
	hl("@lsp.type.interface",     { fg = p.fg })
	hl("@lsp.type.enum",          { fg = p.fg })
	hl("@lsp.type.struct",        { fg = p.fg })
	hl("@lsp.type.parameter",     { fg = p.fg })
	hl("@lsp.type.property",      { fg = p.purple })
	hl("@lsp.type.enumMember",    { fg = p.purple, italic = true })
	hl("@lsp.type.function",      { fg = p.blue })
	hl("@lsp.type.method",        { fg = p.blue })
	hl("@lsp.type.macro",         { fg = p.yellow })
	hl("@lsp.type.decorator",     { fg = p.yellow })
	hl("@lsp.type.namespace",     { fg = p.fg })
	hl("@lsp.mod.static",         { italic = true })
	hl("@lsp.mod.readonly",       { italic = true })

	-- ── diagnostics ─────────────────────────────────────
	hl("DiagnosticError",          { fg = p.error })
	hl("DiagnosticWarn",           { fg = p.warning })
	hl("DiagnosticInfo",           { fg = p.info })
	hl("DiagnosticHint",           { fg = p.hint })
	hl("DiagnosticUnderlineError", { undercurl = true, sp = p.error })
	hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.warning })
	hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.info })
	hl("DiagnosticUnderlineHint",  { undercurl = true, sp = p.hint })
	hl("DiagnosticVirtualTextError", { fg = p.error, bg = "#3A2A2C" })
	hl("DiagnosticVirtualTextWarn",  { fg = p.warning, bg = "#3A352A" })
	hl("DiagnosticVirtualTextInfo",  { fg = p.info, bg = p.bg_dim })
	hl("DiagnosticVirtualTextHint",  { fg = p.hint, bg = p.bg_dim })
	hl("DiagnosticUnnecessary",      { fg = p.fg_dim }) -- unused symbol, like IDEA gray
	hl("LspReferenceText",  { bg = p.bg_dim })
	hl("LspReferenceRead",  { bg = "#373B39" }) -- IDEA read-access highlight
	hl("LspReferenceWrite", { bg = "#40332B" }) -- IDEA write-access highlight
	hl("LspInlayHint",      { fg = p.fg_dim, bg = p.bg_dim, italic = true })

	-- ── diff / git ──────────────────────────────────────
	hl("DiffAdd",     { bg = p.diff_add })
	hl("DiffChange",  { bg = p.diff_change })
	hl("DiffDelete",  { bg = p.diff_delete })
	hl("DiffText",    { bg = "#42597A" })
	hl("Added",       { fg = p.git_add })
	hl("Changed",     { fg = p.git_change })
	hl("Removed",     { fg = p.error })
	hl("GitSignsAdd",    { fg = p.git_add })
	hl("GitSignsChange", { fg = p.git_change })
	hl("GitSignsDelete", { fg = p.git_delete })

	-- ── telescope ───────────────────────────────────────
	hl("TelescopeNormal",         { fg = p.fg, bg = p.bg_alt })
	hl("TelescopeBorder",         { fg = p.border, bg = p.bg_alt })
	hl("TelescopePromptNormal",   { fg = p.fg, bg = p.bg_alt })
	hl("TelescopePromptBorder",   { fg = p.border, bg = p.bg_alt })
	hl("TelescopePromptTitle",    { fg = p.fg, bold = true })
	hl("TelescopeSelection",      { bg = p.selection })
	hl("TelescopeSelectionCaret", { fg = p.blue, bg = p.selection })
	hl("TelescopeMatching",       { fg = p.blue, bold = true })

	-- ── cmp / completion ────────────────────────────────
	hl("CmpItemAbbr",           { fg = p.fg })
	hl("CmpItemAbbrMatch",      { fg = p.blue, bold = true })
	hl("CmpItemAbbrMatchFuzzy", { fg = p.blue })
	hl("CmpItemKindFunction",   { fg = p.blue })
	hl("CmpItemKindMethod",     { fg = p.blue })
	hl("CmpItemKindVariable",   { fg = p.fg })
	hl("CmpItemKindField",      { fg = p.purple })
	hl("CmpItemKindProperty",   { fg = p.purple })
	hl("CmpItemKindClass",      { fg = p.fg })
	hl("CmpItemKindInterface",  { fg = p.fg })
	hl("CmpItemKindKeyword",    { fg = p.orange })
	hl("CmpItemKindSnippet",    { fg = p.green })
	hl("CmpItemKindConstant",   { fg = p.purple })

	-- ── misc plugins ────────────────────────────────────
	hl("IndentBlanklineChar",        { fg = p.border })
	hl("IblIndent",                  { fg = p.border })
	hl("LazyNormal",                 { fg = p.fg, bg = p.bg_alt })
	hl("MasonNormal",                { fg = p.fg, bg = p.bg_alt })
	hl("WhichKeyNormal",             { fg = p.fg, bg = p.bg_alt })
	hl("NvimTreeNormal",             { fg = p.fg, bg = p.bg })
	hl("NeoTreeNormal",              { fg = p.fg, bg = p.bg })

	-- terminal colors
	vim.g.terminal_color_0  = p.bg_alt
	vim.g.terminal_color_1  = p.error
	vim.g.terminal_color_2  = p.green
	vim.g.terminal_color_3  = p.yellow
	vim.g.terminal_color_4  = p.blue
	vim.g.terminal_color_5  = p.purple
	vim.g.terminal_color_6  = p.cyan
	vim.g.terminal_color_7  = p.fg
	vim.g.terminal_color_8  = p.gray
	vim.g.terminal_color_9  = p.error
	vim.g.terminal_color_10 = p.green
	vim.g.terminal_color_11 = p.warning
	vim.g.terminal_color_12 = p.blue
	vim.g.terminal_color_13 = p.purple
	vim.g.terminal_color_14 = p.cyan
	vim.g.terminal_color_15 = "#FFFFFF"
end

return M
