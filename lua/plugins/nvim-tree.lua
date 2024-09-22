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

		vim.api.nvim_create_autocmd("QuitPre", {
			callback = function()
				local tree_wins = {}
				local floating_wins = {}
				local wins = vim.api.nvim_list_wins()
				for _, w in ipairs(wins) do
					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
					if bufname:match("NvimTree_") ~= nil then
						table.insert(tree_wins, w)
					end
					if vim.api.nvim_win_get_config(w).relative ~= '' then
						table.insert(floating_wins, w)
					end
				end
				if 1 == #wins - #floating_wins - #tree_wins then
					-- Should quit, so we close all invalid windows.
					for _, w in ipairs(tree_wins) do
						vim.api.nvim_win_close(w, true)
					end
				end
			end
		})
	end,
}
