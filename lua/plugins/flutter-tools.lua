return {
	'akinsho/flutter-tools.nvim',
	ft = { "dart" },
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = function()
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
				color = { -- show the derived colours for dart variables
					enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
					background = true, -- highlight the background
					background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
					foreground = true, -- highlight the foreground
					virtual_text = true, -- show the highlight using virtual text
					virtual_text_str = "■", -- the virtual text character to highlight
				},
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					renameFilesWithClasses = "always",
					enableSnippets = true,
					updateImportsOnRename = true,
				}
			}
		}
	end,
}
