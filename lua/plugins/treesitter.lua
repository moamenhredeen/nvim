return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		build = ':TSUpdate',
		lazy = false,
		config = function()
			require('nvim-treesitter').setup {}

			local ensure_installed = {
				'lua', 'vim', 'vimdoc', 'query',
				'markdown', 'markdown_inline',
				'javascript', 'typescript', 'tsx', 'json', 'html', 'css',
				'zig', 'c', 'bash', 'yaml', 'toml', 'regex',
				'diff',
			}
			require('nvim-treesitter').install(ensure_installed)

			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
				callback = function(args)
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						vim.wo.foldmethod = 'expr'
						vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = 'main',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('nvim-treesitter-textobjects').setup {
				select = { lookahead = true },
				move = { set_jumps = true },
			}

			local select = require 'nvim-treesitter-textobjects.select'
			vim.keymap.set({ 'x', 'o' }, 'af', function()
				select.select_textobject('@function.outer', 'textobjects')
			end, { desc = 'Select outer function' })
			vim.keymap.set({ 'x', 'o' }, 'if', function()
				select.select_textobject('@function.inner', 'textobjects')
			end, { desc = 'Select inner function' })
			vim.keymap.set({ 'x', 'o' }, 'ac', function()
				select.select_textobject('@class.outer', 'textobjects')
			end, { desc = 'Select outer class' })
			vim.keymap.set({ 'x', 'o' }, 'ic', function()
				select.select_textobject('@class.inner', 'textobjects')
			end, { desc = 'Select inner part of a class region' })
			vim.keymap.set({ 'x', 'o' }, 'as', function()
				select.select_textobject('@local.scope', 'locals')
			end, { desc = 'Select language scope' })

			local move = require 'nvim-treesitter-textobjects.move'
			vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
				move.goto_previous_start('@class.outer', 'textobjects')
			end, { desc = 'Previous class start' })
			vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
				move.goto_next_start('@class.outer', 'textobjects')
			end, { desc = 'Next class start' })
		end,
	},
}
