

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


local executor = require('core.executor')
local map = vim.keymap.set
local opts = { silent = true }



local compile = function ()
	executor.execute_command('typst', {'compile', vim.api.nvim_buf_get_name(0)})
end


local watch = function ()
	executor.execute_command('typst', {'watch', vim.api.nvim_buf_get_name(0)})
end

map('n', '<localleader>r', compile, opts)
map('n', '<localleader>w', watch, opts)
map('n', '<localleader>p', vim.cmd.TypstPreviewToggle, opts)
map('n', '<localleader>f', vim.cmd.Format, opts)
