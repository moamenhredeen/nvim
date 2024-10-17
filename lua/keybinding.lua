-- leader is used define global key mapping
vim.g.mapleader = ' '

-- local leader used to define file type specific key mapping (hence the name local)
vim.g.maplocalleader = ','

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- shortcuts
vim.keymap.set('n', '<Leader>w', ':w<CR>')

-- pane navigation (with tmux integration)
local navigator = require('custom.tmux-integration')
vim.keymap.set({ 'n', 'i', 'v' }, '<C-h>', navigator.TmuxNvimNavigateLeft)
vim.keymap.set({ 'n', 'i', 'v' }, '<C-j>', navigator.TmuxNvimNavigateDown)
vim.keymap.set({ 'n', 'i', 'v' }, '<C-k>', navigator.TmuxNvimNavigateUp)
vim.keymap.set({ 'n', 'i', 'v' }, '<C-l>', navigator.TmuxNvimNavigateRight)
vim.keymap.set({ 'n', 'i', 'v' }, '<C-e>', navigator.TmuxNvimNavigateLastActive)
vim.keymap.set({ 'n', 'i', 'v' }, '<C-t>', function()
	vim.system({ 'tmux', 'split-window', '-v', '-l', '15' })
end)


-- swap
vim.keymap.set('n', '<M-n>', ':windo wincmd H<CR>')
vim.keymap.set('n', '<M-m>', ':windo wincmd K<CR>')

-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })