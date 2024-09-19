

local default_lsp_on_attach_handler = require("core.lsp").default_lsp_on_attach_handler

vim.g.rustaceanvim = {
	server = {
		on_attach = default_lsp_on_attach_handler
	},
	tools = {
		-- executor = 'background',
		-- test_executor = 'background',
		float_win_config = {
			border = 'rounded'
		}
	}
}


return {
	'mrcjkb/rustaceanvim',
	version = '^5', -- Recommended
	lazy = false, -- This plugin is already lazy
}

