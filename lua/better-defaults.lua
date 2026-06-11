-- ***********************************************************************
-- ***
-- *** better defaults
-- ***
-- characters: ✓  ✔  ✕ ✘  ♣ ♠ ♥ ♦ 𝄛



-- disable netrw at the very start of your init.lua (strongly advised)
-- i use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- unfold be default
vim.o.foldlevel = 99
vim.opt.fillchars:append({ fold = ' ' })



-- disable virtual text in neovim
vim.diagnostic.config({
	virtual_text = true,
})

-- render tabs and eol
-- vim.opt.list = true
-- » ⤸ • « ␣
-- vim.opt.listchars = {
-- 	tab = '  ',
-- 	eol = ' ',
-- 	trail = ' ',
-- 	extends = ' ',
-- 	precedes = ' ',
-- 	nbsp = ' ',
-- }

-- cursor shape
vim.o.guicursor = "v-c-i-n:block"


-- status line
vim.o.statusline = " %Y | %m %f %=%l/%L=%p%% "

-- use pwsh (PowerShell 7+) as terminal shell on Windows
if vim.fn.has('win32') == 1 and vim.fn.executable('pwsh') == 1 then
	vim.o.shell = 'pwsh'
	vim.o.shellcmdflag =
		'-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
	vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
	vim.o.shellquote = ''
	vim.o.shellxquote = ''
end

-- start terminal buffers in insert (terminal) mode
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
	pattern = 'term://*',
	callback = function()
		vim.cmd('startinsert')
	end,
})

-- no line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = 'no'
	end,
})

-- better performance
vim.loader.enable()

vim.o.termguicolors = true

-- local colorscheme: colors/jetbrains-dark.lua + lua/jetbrains-dark.lua
vim.o.background = "dark"
vim.cmd.colorscheme("jetbrains-dark")

-- set font for gui neovim clients
vim.opt.guifont = 'JetBrainsMono Nerd Font'

-- highlight current line
vim.o.cursorline = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.o.number = true

-- enable relative number
-- vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.wrap = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.clipboard = 'unnamedplus'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.expandtab = false

-- fold markdown
-- vim.g.markdown_folding = 1

-- additional filetypes
vim.filetype.add({
  pattern = {
    ['.*/.*webc'] = 'html',
  },
})


