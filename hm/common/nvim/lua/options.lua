require 'nvchad.options'

local opt = vim.opt
local g = vim.g
local filetype = vim.filetype

g.vim_markdown_folding_disabled = 1
opt.scrolloff = 999
opt.whichwrap = 'b,s'
opt.wrap = false
opt.conceallevel = 1
opt.winborder = 'single'

if vim.fn.has 'wsl' == 1 then
  g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

filetype.add { extension = { sclin = 'sclin' } }
