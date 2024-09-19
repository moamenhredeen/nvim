-- *************************************************
-- telescope
-- See :help telescope and :help telescope.setup()

return {
	"nvim-telescope/telescope.nvim",
	config =  function()
		local telescope = require('telescope')
		telescope.setup({
			defaults = {
				layout_strategy = 'vertical',
				layout_config = { height = 0.5 },
				border = false,
				preview = false,
				-- center current buffer after jumping to the search result
				mappings = {
					i = {
						["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
					},
					n = {
						["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
					}
				}
			},
			pickers = {
				find_files = { theme = "ivy" },
				buffers = { theme = "ivy" },
				git_branches = { theme = "ivy" },
				lsp_document_symbols = { theme = "ivy" },
				lsp_dynamic_workspace_symbols = { theme = "ivy" },
				help_tags = { theme = "ivy" },
				commands = { theme = "ivy" },
				live_grep = { theme = "ivy", previewer = true },
				current_buffer_fuzzy_find = { theme = "ivy", previewer = true },
			},
		})
		local telescope_builtin = require('telescope.builtin')
		pcall(telescope.load_extension, 'fzf')
		vim.keymap.set('n', '<Leader>f', telescope_builtin.find_files, { desc = 'open [F]ile' })
		vim.keymap.set('n', '<Leader>b', function()
			telescope_builtin.buffers({ sort_lastused = true, only_cwd = true, ignore_current_buffer = true });
		end, { desc = 'open [B]uffer' })
		vim.keymap.set('n', '<Leader>x', telescope_builtin.commands, { desc = '[C]ommands' })
		vim.keymap.set('n', '<Leader>ss', telescope_builtin.builtin, { desc = 'List Telescope Bultin' })
		vim.keymap.set('n', '<Leader>sh', telescope_builtin.help_tags, { desc = '[H]elp' })
		vim.keymap.set('n', '<Leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<Leader>sb', telescope_builtin.current_buffer_fuzzy_find,
		{ desc = '[/] Fuzzily search in current buffer]' })
		vim.keymap.set('n', '<Leader>ca', telescope_builtin.git_commits, { desc = '[A]ll Commits' })
		vim.keymap.set('n', '<Leader>cc', telescope_builtin.git_bcommits, { desc = '[C]ommmits for this buffer' })
		vim.keymap.set('n', '<Leader>cb', telescope_builtin.git_branches, { desc = '[B]ranches' })
	end

}

