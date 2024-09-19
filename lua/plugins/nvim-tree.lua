-- ***********************************************************************
-- nvim tree
--
return {
	'nvim-tree/nvim-tree.lua',
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	config = function()
		local api = require('nvim-tree.api')

		local my_on_attach = function(bufnr)
			api.config.mappings.default_on_attach(bufnr)
		end

		require("nvim-tree").setup {
			on_attach = my_on_attach,
			sort_by = "case_sensitive",
			view = {
				adaptive_size = true,
			},
			renderer = {
				group_empty = true,
				icons = {
					show = {
						file = true,
						folder = true
					}
				}
			},
			-- filters = {
				-- 	dotfiles = true,
				-- },
			}

			vim.keymap.set('n', '<Leader>e', function()
				api.tree.open({
					find_file = true
				})
			end)
		end,
	}
