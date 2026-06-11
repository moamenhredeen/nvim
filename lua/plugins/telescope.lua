-- *************************************************
-- telescope
-- See :help telescope and :help telescope.setup()

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		'nvim-telescope/telescope-ui-select.nvim'
	},
	config = function()
		local telescope = require('telescope')
		local telescope_actions = require('telescope.actions')
		telescope.setup({
			defaults = require('telescope.themes').get_ivy({
				preview = false,
				mappings = {
					i = {
						["<CR>"] = telescope_actions.select_default + telescope_actions.center,
						["jk"] = telescope_actions.close,
					},
					n = {
						["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
					}
				}
			}),
		})
		local telescope_builtin = require('telescope.builtin')
		pcall(telescope.load_extension, 'fzf')

		-- in flutter projects restrict searching to lib/ and test/ (skip android/, ios/, build/ ...)
		local project_search_dirs = function()
			if vim.uv.fs_stat(vim.fn.getcwd() .. '/pubspec.yaml') then
				return vim.tbl_filter(function(dir)
					return vim.fn.isdirectory(dir) == 1
				end, { 'lib', 'test' })
			end
			return nil
		end

		vim.keymap.set('n', '<Leader>f', function()
			telescope_builtin.find_files({ search_dirs = project_search_dirs() })
		end, { desc = 'open [F]ile' })
		vim.keymap.set('n', '<Leader>b', function()
			telescope_builtin.buffers({ sort_lastused = true, only_cwd = true, ignore_current_buffer = true });
		end, { desc = 'open [B]uffer' })
		vim.keymap.set('n', '<Leader>x', telescope_builtin.commands, { desc = '[C]ommands' })
		vim.keymap.set('n', '<Leader>ss', telescope_builtin.builtin, { desc = 'List Telescope Bultin' })
		vim.keymap.set('n', '<Leader>sh', telescope_builtin.help_tags, { desc = '[H]elp' })
		vim.keymap.set('n', '<Leader>sg', function()
			telescope_builtin.live_grep({ search_dirs = project_search_dirs() })
		end, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<Leader>sb', telescope_builtin.current_buffer_fuzzy_find,
			{ desc = '[/] Fuzzily search in current buffer]' })
		vim.keymap.set('n', '<Leader>ca', telescope_builtin.git_commits, { desc = '[A]ll Commits' })
		vim.keymap.set('n', '<Leader>cc', telescope_builtin.git_bcommits, { desc = '[C]ommmits for this buffer' })
		vim.keymap.set('n', '<Leader>cb', telescope_builtin.git_branches, { desc = '[B]ranches' })

		telescope.load_extension('ui-select')
		telescope.load_extension("flutter")
	end
}
