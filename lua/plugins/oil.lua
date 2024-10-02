return {
	'stevearc/oil.nvim',
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	opts = {
		default_file_explorer = false,
		skip_confirm_for_simple_edits = true,
		-- (:help prompt_save_on_select_new_entry)
		prompt_save_on_select_new_entry = false,

		-- Configuration for the floating window in oil.open_float
		float = {
			-- Padding around the floating window
			padding = 2,
			max_width = 100,
			max_height = 30,
			-- border = "rounded",
		},
	},
	keys = {
		{ "<leader>E", ":Oil --float<CR>", desc = "Open parent directory in oil" }
	},
}
