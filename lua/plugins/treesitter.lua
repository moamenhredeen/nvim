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
			},
			auto_intall = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlight = false
			},
			ident = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "<Space>",
					-- scope_incremental = "grc",
					node_decremental = "<BS>",
				},
			},
		})
	end
}
