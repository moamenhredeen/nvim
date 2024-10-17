-- check if the server exists
if not vim.fn.executable("typst-lsp") then
	vim.notify("typst langauge server could not be found.", vim.log.levels.WARN)
	return
end


local on_attach = require('custom.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'typst-lsp',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'typst-lsp' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fn.getcwd(),
	on_attach = on_attach,
})


local executor = require('custom.executor')
local map = vim.keymap.set
local opts = { silent = true }



local compile = function()
	executor.execute_command('typst', { 'compile', vim.api.nvim_buf_get_name(0) })
end


local watch = function()
	executor.execute_command('typst', { 'watch', vim.api.nvim_buf_get_name(0) })
end

map('n', '<localleader>r', compile, opts)
map('n', '<localleader>w', watch, opts)
map('n', '<localleader>p', vim.cmd.TypstPreviewToggle, opts)
map('n', '<localleader>f', vim.cmd.Format, opts)
