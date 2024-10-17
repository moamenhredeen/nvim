-- check if the server exists
if not vim.fn.executable("tsserver") then
	vim.notify("tsserver (typscript langauge server) could not be found.", vim.log.levels.WARN)
	return
end


local on_attach = require('custom.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'tsserver',
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'typescript-language-server', '--stdio' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fs.root(0, { '.git', 'tsconfig.json', 'jsconfig.js', 'package.json' }),
	on_attach = on_attach,
})
