local default_lsp_on_attach_handler = require('core.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'marksman',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'marksman', 'server' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fs.root(0, { '.git', '.marksman.toml' }),
	on_attach = default_lsp_on_attach_handler,
	settings = {
	},
})
