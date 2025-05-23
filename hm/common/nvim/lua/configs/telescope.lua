local telescope = require 'telescope'
local opts = require 'nvchad.configs.telescope'

vim.list_extend(opts.extensions_list, { 'persisted' })

opts.defaults.mappings.i = {
  ['<C-j>'] = 'move_selection_next',
  ['<C-k>'] = 'move_selection_previous',
}

telescope.setup(opts)
telescope.load_extension 'fzf'
telescope.load_extension 'ui-select'
