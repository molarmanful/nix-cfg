return function(self)
  local metals = require 'metals'
  local config = metals.bare_config()
  local set = vim.keymap.set

  config.settings = {
    showImplicitArguments = true,
  }

  config.capabilities = require('cmp_nvim_lsp').default_capabilities()

  config.on_attach = function(client, bufnr)
    require 'util.saveform'(client, bufnr)
    require 'util.lspkeys'(bufnr)
  end

  local metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = self.ft,
    callback = function()
      require('metals').initialize_or_attach(config)
    end,
    group = metals_group,
  })
end
