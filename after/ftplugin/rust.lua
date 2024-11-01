-- vim.api.nvim_create_autocmd('BufWritePre', {
-- 	group = vim.api.nvim_create_augroup('trim_whitespaces', { clear = true }),
-- 	desc = 'Trim trailing white spaces',
-- 	pattern = '<buffer>',
-- 	callback = require('custom.utils').trim_trailing_whitespaces
-- })

vim.o.makeprg = 'cargo build --release'
