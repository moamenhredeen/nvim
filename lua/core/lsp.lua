
local _M = {}


local nmap = function(keys, func, desc)
	if desc then
		desc = 'LSP: ' .. desc
	end
	vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end


-- default lsp on_attach handler
-- @param client vim.lsp.Client
-- @param bufnr integer
_M.default_lsp_on_attach_handler = function(client, bufnr)
	local telescope_built_ins = require('telescope.builtin')
	nmap('ga', vim.lsp.buf.code_action, '[A]ction')
	nmap('<Leader>a', vim.lsp.buf.code_action, '[A]ction')
	nmap('<Leader>rr', vim.lsp.buf.rename, '[R]efactor [R]ename')
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', telescope_built_ins.lsp_references, '[G]oto [R]eferences')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('gs', telescope_built_ins.lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('gS', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('<Leader>t', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<Leader>o', telescope_built_ins.lsp_document_symbols, 'Document [O]utline')
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end


return _M
