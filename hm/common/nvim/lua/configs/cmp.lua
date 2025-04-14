local cmp = require 'cmp'
local opts = require 'nvchad.configs.cmp'

vim.list_extend(opts.sources, {
  { name = 'conjure' },
})

for k, v in pairs {
  ['<Tab>'] = cmp.mapping.confirm(),
  ['<C-j>'] = cmp.mapping.select_next_item(),
  ['<C-k>'] = cmp.mapping.select_prev_item(),
  ['<S-Tab>'] = cmp.config.disable,
  ['<CR>'] = cmp.config.disable,
} do
  opts.mapping[k] = v
end

cmp.setup(opts)
