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
-- vim.diagnostic.config({
-- 	virtual_text = false,
-- })

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

-- better performance
vim.loader.enable()

vim.o.termguicolors = true

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
