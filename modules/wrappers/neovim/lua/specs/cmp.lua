return {
  {
    'friendly-snippets',
    dep_of = { 'luasnip', 'blink.cmp' },
  },

  {
    'luasnip',
    dep_of = { 'blink.cmp' },
    after = function()
      require('luasnip').config.set_config {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
      }
      require('luasnip.loaders.from_vscode').lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
      require('luasnip.loaders.from_vscode').lazy_load { paths = vim.g.vscode_snippets_path or '' }
      require('luasnip.loaders.from_snipmate').load()
      require('luasnip.loaders.from_snipmate').lazy_load { paths = vim.g.snipmate_snippets_path or '' }
      require('luasnip.loaders.from_lua').load()
      require('luasnip.loaders.from_lua').lazy_load { paths = vim.g.lua_snippets_path or '' }
    end,
  },

  {
    'nvim-autopairs',
    dep_of = { 'blink.cmp' },
    after = function()
      require('nvim-autopairs').setup {
        fast_wrap = {},
        disable_filetype = { 'TelescopePrompt', 'vim' },
      }
    end,
  },

  {
    'blink.cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    after = function()
      require('blink.cmp').setup {
        snippets = { preset = 'luasnip' },
        cmdline = { enabled = true },
        appearance = { nerd_font_variant = 'normal' },
        fuzzy = { implementation = 'prefer_rust' },
        signature = { enabled = true },

        sources = { default = { 'lsp', 'snippets', 'buffer', 'path' } },

        keymap = {
          preset = 'default',
          ['<Tab>'] = { 'select_and_accept', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<S-Tab>'] = { 'hide', 'fallback' },
          ['<CR>'] = { 'hide', 'fallback' },
        },

        completion = {
          accept = {
            auto_brackets = { enabled = true },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = 'single' },
          },
          menu = require('nvchad.blink').menu,
        },
      }
    end,
  },
}
