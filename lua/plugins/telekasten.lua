return {
	'renerocksai/telekasten.nvim',
	dependencies = {
		'nvim-telescope/telescope.nvim'
	},
	config = function()
		require('telekasten').setup({
			home = vim.fn.expand("~/zettelkasten"),
			insert_after_inserting = false
		})

		-- Most used functions
		vim.keymap.set("n", "<leader>zf", function()
			vim.cmd('Telekasten search_notes')
			vim.api.nvim_del_current_line()
		end)
		vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
		vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
		vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
		vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")

		-- Call insert link automatically when we start typing a link
		vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
	end
}
