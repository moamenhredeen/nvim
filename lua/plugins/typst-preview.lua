return {
	'chomosuke/typst-preview.nvim',
	lazy = true,
	ft = 'typst',
	version = '0.3.*',
	build = function() require 'typst-preview'.update() end,
}
