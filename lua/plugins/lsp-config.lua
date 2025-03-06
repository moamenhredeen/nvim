
local on_attach = function(client, bufnr)
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
		lspconfig.ts_ls.setup {
			on_attach = on_attach,
			root_dir = "package.json"
		}
		lspconfig.denols.setup {
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
