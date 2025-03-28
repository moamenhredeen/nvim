---@diagnostic disable: missing-fields
return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
	},
	config = function()
		require('nvim-treesitter.configs').setup {
			sync_install = false,
			ignore_install = {},
			modules = {
				highlight = {
					enable = true,
					additional_vim_regex_highlight = true
				},
				indent = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_previous = {
						["[c"] = "@class.outer",
					},
					goto_next = {
						["]c"] = "@class.outer",
					},
				},
			}
		}


		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end,
}
