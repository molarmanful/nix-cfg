local lf = require 'lsp-format'

local supported = { 'null-ls', 'dprint', 'ruff', 'taplo', 'biome', 'rust_analyzer' }

local config = {}
for _, v in pairs(vim.fn.getcompletion('', 'filetype')) do
  config[v] = { sync = true }
end
lf.setup(config)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        command = 'LspEslintFixAll',
      })
    elseif vim.tbl_contains(supported, client.name) then
      lf.on_attach(client, args.buf)
    end
  end,
})
