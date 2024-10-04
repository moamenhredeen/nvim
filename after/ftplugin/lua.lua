-- check if the server exists
if not vim.fn.executable("lua-language-server") then
	vim.notify("lua language server could not be found.", vim.log.levels.WARN)
	return
end

local on_attach = require('core.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'LuaLS',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'lua-language-server' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fn.getcwd(),
	on_attach = on_attach,
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


vim.keymap.set('n', '<localleader>r', ':luafile %<CR>', { silent = true })
