local commands = require('flutter-tools.commands')
vim.keymap.set('n', '<localleader>x', require('telescope').extensions.flutter.commands)
vim.keymap.set('n', '<localleader>r', commands.run)
vim.keymap.set('n', '<localleader>R', commands.restart)
vim.keymap.set('n', '<localleader>v', commands.visual_debug)
vim.keymap.set('n', '<localleader>i', commands.install)
vim.keymap.set('n', '<localleader>q', commands.quit)
vim.keymap.set('n', '<localleader>g', commands.pub_get)
vim.keymap.set('n', '<localleader>u', commands.pub_upgrade)
vim.keymap.set('n', '<localleader>o', require('flutter-tools.outline').toggle)
