local set = vim.keymap.set

return function(bufnr)
  set('n', 'gd', '<cmd> Telescope lsp_definitions <CR>', { desc = 'telescope Find LSP definitions', buffer = bufnr })
  set('n', 'gr', '<cmd> Telescope lsp_references <CR>', { desc = 'telescope Find LSP references', buffer = bufnr })
end
