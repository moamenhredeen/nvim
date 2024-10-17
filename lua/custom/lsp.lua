local _M = {}



-- default lsp on_attach handler
-- @param client vim.lsp.Client
-- @param bufnr integer
_M.default_lsp_on_attach_handler = function(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil

	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end
		vim.keymap.set('n', keys, func, { desc = desc })
	end

	local telescope_built_ins = require('telescope.builtin')

	-- lsp actions
	nmap('<Leader>a', vim.lsp.buf.code_action, '[A]ction')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

	-- refactoring
	nmap('<Leader>rr', vim.lsp.buf.rename, '[R]efactor [R]ename')

	-- code navigation
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', telescope_built_ins.lsp_references, '[G]oto [R]eferences')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')


	-- find a symbol
	nmap('gs', telescope_built_ins.lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('gS', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('<Leader>t', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('<Leader>o', telescope_built_ins.lsp_document_symbols, 'Document [O]utline')

	-- vim.lsp.inlay_hint.enable()
end


return _M
