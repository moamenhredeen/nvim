

local default_lsp_on_attach_handler = require('core.lsp').default_lsp_on_attach_handler

vim.lsp.start({
	name = 'typst-lsp',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'typst-lsp' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = vim.fn.getcwd(),
	on_attach = default_lsp_on_attach_handler,
	settings = {
	},
})


local map = vim.keymap.set
local opts = { silent = true }

map('n', '<localleader>p', vim.cmd.TypstPreviewToggle, opts)
map('n', '<localleader>f', vim.cmd.Format, opts)
