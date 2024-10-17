-- check if the server exists
if not vim.fn.executable("harper-ls") then
	vim.notify("harper language server could not be found.", vim.log.levels.WARN)
	return
end


-- Start "harper" language server
vim.lsp.start({
	name = 'harper-ls',
	single_file_support = true,
	cmd = { 'harper-ls', '-s' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	settings = {
		linters = {
			spell_check = true,
			spelled_numbers = false,
			an_a = true,
			sentence_capitalization = true,
			unclosed_quotes = true,
			wrong_quotes = false,
			long_sentences = true,
			repeated_words = true,
			spaces = true,
			matcher = true,
			correct_number_suffix = true,
			number_suffix_capitalization = true,
			multiple_sequential_pronouns = true,
			linking_verbs = false,
			avoid_curses = true,
			terminating_conjunctions = true
		}
	}
})
