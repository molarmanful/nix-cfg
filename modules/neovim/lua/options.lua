local o = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ','

o.laststatus = 3
o.showmode = false
o.splitkeep = 'screen'

o.clipboard = 'unnamedplus'
o.cursorline = true
o.cursorlineopt = 'number'

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.fillchars = { eob = ' ' }
o.ignorecase = true
o.smartcase = true
o.mouse = 'a'

o.number = true
o.numberwidth = 2
o.ruler = false

o.shortmess:append 'sI'

o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

o.updatetime = 250

o.whichwrap:append '<>[]'

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

o.scrolloff = 999
o.conceallevel = 1
o.winborder = 'single'
