return {
	'renerocksai/telekasten.nvim',
	dependencies = {
		'nvim-telescope/telescope.nvim'
	},
	config = function()
		require('telekasten').setup({
			home = vim.fn.expand("~/notes"),
			insert_after_inserting = false
		})

		-- Most used functions
		vim.keymap.set("n", "<leader>zf", function()
			vim.cmd('Telekasten search_notes')
			vim.api.nvim_del_current_line()
		end)
		vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
		vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
	end
}
