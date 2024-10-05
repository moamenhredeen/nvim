-- check if rust-analyzer installed
if not vim.fn.executable("rust-analyzer") then
	vim.notify("rust-analyzer (rust langauge server) could not be found.", vim.log.levels.WARN)
	return {}
end

local on_attach = function()
	local nmap = function(keys, func)
		vim.keymap.set('n', keys, func, { silent = true })
	end

	local telescope_built_ins = require('telescope.builtin')

	-- actions
	nmap('<Leader>a', vim.lsp.buf.code_action)
	nmap('<localleader>a', function() vim.cmd.RustLsp('codeAction') end)
	nmap('K', vim.lsp.buf.hover)

	-- refactoring
	nmap('<Leader>rr', vim.lsp.buf.rename)

	-- code navigation
	nmap('gd', vim.lsp.buf.definition)
	nmap('gr', telescope_built_ins.lsp_references)
	nmap('gi', vim.lsp.buf.implementation)

	-- find a symbol
	nmap('gs', telescope_built_ins.lsp_document_symbols)
	nmap('<Leader>o', telescope_built_ins.lsp_document_symbols)
	nmap('gS', telescope_built_ins.lsp_dynamic_workspace_symbols)
	nmap('<Leader>t', telescope_built_ins.lsp_dynamic_workspace_symbols)

	-- run and test
	nmap('<localleader>r', function() vim.cmd.RustLsp { 'runnables', bang = true } end)
	nmap('<localleader>R', function() vim.cmd.RustLsp { 'runnables' } end)
	nmap('<localleader>t', function() vim.cmd.RustLsp { 'testables', bang = true } end)
	nmap('<localleader>T', function() vim.cmd.RustLsp('testables') end)

	-- disgnostics
	nmap('<localleader>e', function() vim.cmd.RustLsp { 'explainError', 'current' } end)
	nmap('<localleader>d', function() vim.cmd.RustLsp { 'renderDiagnostic', 'current' } end)
	nmap('<localleader>n', function() vim.cmd.RustLsp { 'renderDiagnostic', 'cycle' } end)
	nmap('<localleader>c', function() vim.cmd.RustLsp('flyCheck') end)

	-- cargo related
	nmap('<localleader>p', function() vim.cmd.RustLsp('openCargo') end)

	-- inspect
	nmap('<localleader>i', function() vim.cmd.RustLsp { 'view', 'hir' } end)
	nmap('<localleader>I', function() vim.cmd.RustLsp { 'view', 'mir' } end)

	-- vim.lsp.inlay_hint.enable()
end

vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach
	},
	tools = {
		code_actions = {
			ui_select_fallback = true
		},
		float_win_config = {
			border = 'rounded',
		},
		-- test_executor = 'background'
	}
}


return {
	'mrcjkb/rustaceanvim',
	version = '^5', -- Recommended
	lazy = false, -- This plugin is already lazy
}
