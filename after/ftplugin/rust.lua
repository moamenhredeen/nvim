local map = vim.keymap.set
local opts = { silent = true }


map('n', '<localleader>r', function() vim.cmd.RustLsp { 'runnables', bang = true } end, opts)
map('n', '<localleader>R', function() vim.cmd.RustLsp { 'runnables' } end, opts)
map('n', '<localleader>t', function() vim.cmd.RustLsp { 'testables', bang = true } end, opts)
map('n', '<localleader>T', function() vim.cmd.RustLsp('testables') end, opts)
map('n', '<localleader>a', function() vim.cmd.RustLsp('codeAction') end, opts)
map('n', '<localleader>e', function() vim.cmd.RustLsp('explainError') end, opts)
map('n', '<localleader>d', function() vim.cmd.RustLsp('renderDiagnostic') end, opts)
map('n', '<localleader>p', function() vim.cmd.RustLsp('openCargo') end, opts)
map('n', '<localleader>c', function() vim.cmd.RustLsp('flyCheck') end, opts)
map('n', '<localleader>v', function() vim.cmd.RustLsp { 'view', 'hir' } end, opts)


-- vim.api.nvim_create_autocmd('BufWritePre', {
-- 	group = vim.api.nvim_create_augroup('trim_whitespaces', { clear = true }),
-- 	desc = 'Trim trailing white spaces',
-- 	pattern = '<buffer>',
-- 	callback = require('core.utils').trim_trailing_whitespaces
-- })
