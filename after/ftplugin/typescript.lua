
local default_lsp_on_attach_handler = require('core.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'tsserver',
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'typescript-language-server', '--stdio' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
 	root_dir = vim.fs.root(0, {'.git', 'tsconfig.json', 'jsconfig.js', 'package.json'}),
	on_attach = default_lsp_on_attach_handler,
	settings = {
	},
})
