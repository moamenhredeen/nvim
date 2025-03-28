return {
	'akinsho/flutter-tools.nvim',
	ft = { "dart" },
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = function()
		local my_custom_on_attach = function(client, _)
			client.server_capabilities.semanticTokensProvider = nil

			local nmap = function(keys, func, desc)
				if desc then
					desc = 'LSP: ' .. desc
				end
				vim.keymap.set('n', keys, func, { desc = desc })
			end

			local telescope_built_ins = require('telescope.builtin')

			local find_document_symbol = function()
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

			nmap('<leader>d', function()
				vim.diagnostic.open_float({
					scope = "line",
				})
			end, "Show [D]iagnostic under Cursor")

			-- refactoring
			nmap('<Leader>rr', vim.lsp.buf.rename, '[R]efactor [R]ename')

			-- code navigation
			nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
			nmap('gr', telescope_built_ins.lsp_references, '[G]oto [R]eferences')
			nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')


			-- find a symbol
			nmap('gs', find_document_symbol, '[D]ocument [S]ymbols')
			nmap('gS', telescope_built_ins.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
			nmap('<Leader>o', find_document_symbol, 'Document [O]utline')
		end

		require("flutter-tools").setup {
			decorations = {
				statusline = {
					device = true,
				}
			},
			-- TODO: setup fvm
			-- fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
			widget_guides = {
				enabled = true,
			},
			dev_log = {
				enabled = true,
				filter = nil, -- optional callback to filter the log
				-- takes a log_line as string argument; returns a boolean or nil;
				-- the log_line is only added to the output if the function returns true
				notify_errors = false, -- if there is an error whilst running then notify the user
				open_cmd = "15new", -- command to use to open the log buffer
			},
			dev_tools = {
				autostart = false,     -- autostart devtools server if not detected
				auto_open_browser = false, -- Automatically opens devtools in the browser
			},
			outline = {
				open_cmd = "30vnew",
				auto_open = false,
			},
			lsp = {
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					renameFilesWithClasses = "always",
					enableSnippets = true,
					updateImportsOnRename = true,
				},
				on_attach = my_custom_on_attach,
			}
		}
	end,
}
