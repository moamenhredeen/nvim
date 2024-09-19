return {
	'nvim-treesitter/nvim-treesitter-context',
	config = function()
		require'treesitter-context'.setup{
			enable = true,
			max_lines = 0,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = 'outer',
			mode = 'cursor',
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			-- ∙
			separator = '─',
			zindex = 20,
			on_attach = nil,
		}

		vim.api.nvim_set_hl(0, 'TreesitterContext', {bg = 'none'})
	end
}
