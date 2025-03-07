return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	dependencies = {
		'nvim-treesitter/nvim-treesitter'
	},
	config = function ()
		---@diagnostic disable
		require('nvim-treesitter.configs').setup {
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
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[s"] = { query = "@local.scope", query_group = "locals" },
					},
					goto_next_end = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]s"] = { query = "@local.scope", query_group = "locals" },
					},
				},
			}
		}
	end,
}
