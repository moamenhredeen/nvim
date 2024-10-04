-- check if the server exists
if not vim.fn.executable("gopls") then
	vim.notify("gopls (go langauge server) could not be found.", vim.log.levels.WARN)
	return
end

local on_attach = require('core.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'gopls',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'gopls' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fs.root(0, { 'go.mod', 'go.work', '.git' }),
	on_attach = on_attach,
})
