-- check if the server exists
if not vim.fn.executable("clangd") then
	vim.notify("clangd could not be found.", vim.log.levels.WARN)
	return
end

local on_attach = require('custom.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'clangd',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'clangd' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fs.root(0, { 'Makefile', 'CmakeLists.txt', '.git' }),
	on_attach = on_attach,
})

-- local dap = require('dap')
-- dap.adapters.cppdbg = {
-- 	id = 'cppdbg',
-- 	type = 'executable',
-- 	command = '/absolute/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
-- }
