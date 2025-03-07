return {
	'saghen/blink.cmp',
	version = '*',
	opts = {
		keymap = {
			preset = 'super-tab',
			['<CR>'] = { 'accept', 'fallback' },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},
		cmdline = {
			enabled = false,
		},
		sources = {
			default = { 'lsp', 'path', 'snippets' },
		},
		completion = {
			menu = {
				auto_show = true,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
			}
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" }
}
