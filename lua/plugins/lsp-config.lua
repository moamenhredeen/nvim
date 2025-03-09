
---@type integer?  stores the id of the autogruop of the diagnostic quickfix auto command
local _diagnosticAutoGroupId = nil

local _openDiagnosticQuickList = function ()
	local win_id = vim.api.nvim_get_current_win()
	vim.diagnostic.setqflist({
		title = "Workspace Diagnostics"
	})
	vim.api.nvim_set_current_win(win_id)
end

local on_attach = function(client, _)
	client.server_capabilities.semanticTokensProvider = nil

	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end
		vim.keymap.set('n', keys, func, { desc = desc })
	end

	local telescope_built_ins = require('telescope.builtin')

	local find_document_symbol = function ()
		telescope_built_ins.lsp_document_symbols {
			show_line = true,
			symbols = {
				"module",
				"namespace",
				"package",
				"class",
				"method",
				"property",
				"interface",
				"enum",
				"struct",
				"function",
			}
		}
	end

	-- lsp actions
	nmap('<Leader>a', vim.lsp.buf.code_action, '[A]ction')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

	nmap('<leader>d', function ()
		vim.diagnostic.open_float({
			scope = "line",
		})
	end, "Show [D]iagnostic under Cursor")

	nmap("<leader>qd", function ()
		if _diagnosticAutoGroupId then
			pcall(vim.api.nvim_del_augroup_by_id, _diagnosticAutoGroupId)
			vim.cmd[[cclose]]
			_diagnosticAutoGroupId = nil
		else
			_diagnosticAutoGroupId = vim.api.nvim_create_augroup("diagnostic-quickfix-group", {});
			vim.api.nvim_create_autocmd('DiagnosticChanged', {
				group = _diagnosticAutoGroupId,
				callback = function(_)
					_openDiagnosticQuickList()
				end,
			})
			_openDiagnosticQuickList()
		end
	end, "toggle [Q]uick list [Diagnostics]")

	-- refactoring
	nmap('<Leader>rr', vim.lsp.buf.rename, '[R]efactor [R]ename')

	-- code navigation
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', telescope_built_ins.lsp_references, '[G]oto [R]eferences')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')


	-- find a symbol
	nmap('gs', find_document_symbol, '[D]ocument [S]ymbols')
	nmap('gS', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('<Leader>t', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('<Leader>o', find_document_symbol, 'Document [O]utline')
end

-- lsp config plugin
return {
	'neovim/nvim-lspconfig',
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function ()
		require("mason").setup()
		require("mason-lspconfig").setup()
		local lspconfig = require('lspconfig')
		lspconfig.angularls.setup {
			on_attach = on_attach,
		}
		lspconfig.ts_ls.setup {
			on_attach = on_attach,
		}
		lspconfig.zls.setup {
			on_attach = on_attach
		}
		lspconfig.tinymist.setup {
			on_attach = on_attach
		}
		lspconfig.angularls.setup {
			on_attach = on_attach
		}


		lspconfig.svelte.setup{
			on_attach = on_attach
		}

		lspconfig.marksman.setup{}

		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			on_init = function(client)
				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT'
					},
					workspace = {
						checkThirdParty = false,

        		library = vim.api.nvim_get_runtime_file("", true)
						-- library = {
						-- 	vim.env.VIMRUNTIME
						-- }
					}
				})
			end,
			settings = {
				Lua = {}
			}
		}
	end
}
