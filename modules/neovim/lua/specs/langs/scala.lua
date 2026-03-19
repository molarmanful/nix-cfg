return {
  {
    'nvim-metals',
    ft = { 'scala', 'sbt', 'java' },
    after = function(plugin)
      local metals = require 'metals'
      local config = metals.bare_config()

      config.settings = {
        showImplicitArguments = true,
      }

      local metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = plugin.ft,
        callback = function()
          require('metals').initialize_or_attach(config)
        end,
        group = metals_group,
      })
    end,
  },
}
