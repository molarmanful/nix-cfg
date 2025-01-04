vim.g.base46_cache = vim.fn.stdpath 'data' .. '/nvchad/base46/'
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local lazy_config = require 'configs.lazy'

-- load plugins
require('nixCatsUtils.lazyCat').setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  {
    'NvChad/NvChad',
    lazy = false,
    branch = 'v2.5',
    import = 'nvchad.plugins',
  },

  { import = 'plugins' },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')

require 'options'
require 'nvchad.autocmds'

vim.schedule(function()
  require 'mappings'
end)
require 'myinit'
