
local default_lsp_on_attach_handler = require('core.lsp').default_lsp_on_attach_handler
local root_dir = vim.fs.root(0, { 'build.zig', 'build.zig.zon' })

-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
vim.diagnostic.config({ virtual_text = true })

vim.lsp.start({
	name = 'zls',
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	cmd = { 'zls' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
 	root_dir = root_dir,
	on_attach = default_lsp_on_attach_handler,
	settings = {
	},
})



local executor = require('core.executor')
local opts = { silent = true }

-- run zig project
vim.keymap.set('n', '<localleader>r', function ()
	executor.execute_command('zig', {'run', root_dir .. '/src/main.zig'})
end, opts)

vim.keymap.set('n', '<localleader>b', function ()
	executor.execute_command('zig', {'build'})
end, opts)


vim.keymap.set('n', '<localleader>t', function ()
	executor.execute_command('zig', {'test', vim.api.nvim_buf_get_name(0)})
end, opts)


vim.keymap.set('n', '<localleader>f', vim.cmd.Format, opts)