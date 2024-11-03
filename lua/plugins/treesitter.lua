-- *************************************************
-- configure treesitter
--

return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"go",
				"javascript",
				"typescript",
				"scss",
				"zig",
				"rust",
				"toml",
				"java",
				"angular",
				"typst",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			ignore_install = {},
			auto_install = true,
			modules = {
				highlight = {
					enable = true,
					additional_vim_regex_highlight = false
				},
				indent = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "<Space>",
						node_decremental = "<BS>",
					},
				},
			},
		})

		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end,
}
