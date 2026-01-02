local lf = require 'lsp-format'

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        command = 'LspEslintFixAll',
      })
      return
    end

    if
      ({
        ['null-ls'] = 1,
        dprint = 1,
        ruff = 1,
        taplo = 1,
        biome = 1,
      })[client.name]
    then
      lf.on_attach(client, args.buf)
    end
  end,
})
