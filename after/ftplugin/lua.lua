
local default_lsp_on_attach_handler = require('core.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'LuaLS',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'lua-language-server' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fn.getcwd(),
	on_attach = default_lsp_on_attach_handler,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				globals = { 'vim' },
				disable = { 'lowercase-global' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
		},
	},
})
