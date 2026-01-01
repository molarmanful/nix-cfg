require 'nvchad.autocmds'

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client:supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = args.buf }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end

    if client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        command = 'LspEslintFixAll',
      })
    end
  end,
})
