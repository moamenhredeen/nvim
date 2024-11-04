-- check if the server exists
if not vim.fn.executable("marksman") then
	vim.notify("marksman (markdown langauge server) could not be found.", vim.log.levels.WARN)
	return
end

local on_attach = require('custom.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'bash-language-server',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'bash-language-server', 'start' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fn.getcwd(),
	on_attach = on_attach,
})
