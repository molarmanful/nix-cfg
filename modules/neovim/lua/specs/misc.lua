return {
  {
    'persisted.nvim',
    lazy = false,
    after = function()
      require('persisted').setup {
        use_git_branch = true,
        autoload = true,
      }
    end,
  },

  { 'vim-repeat', event = 'DeferredUIEnter' },

  {
    'leap.nvim',
    lazy = false,
    after = function()
      local set = vim.keymap.set
      set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)', { desc = 'leap leap' })
      set('n', 'S', '<Plug>(leap-from-window)', { desc = 'leap leap from window' })

      do
        local function as_ft(specific)
          local common = {
            inputlen = 1,
            inclusive = true,
            opts = {
              labels = '',
              safe_labels = vim.fn.mode(1):match '[no]' and '' or nil,
            },
          }
          return vim.tbl_deep_extend('keep', common, specific)
        end

        local clever = require('leap.user').with_traversal_keys
        local clever_f = clever('f', 'F')
        local clever_t = clever('t', 'T')

        for key, specific in pairs {
          f = { opts = clever_f },
          F = { backward = true, opts = clever_f },
          t = { offset = -1, opts = clever_t },
          T = { backward = true, offset = 1, opts = clever_t },
        } do
          set({ 'n', 'x', 'o' }, key, function()
            require('leap').leap(as_ft(specific))
          end)
        end
      end
    end,
  },

  {
    'nvim-surround',
    event = 'DeferredUIEnter',
  },

  {
    'guess-indent.nvim',
    lazy = false,
    after = function()
      require('guess-indent').setup {}
    end,
  },

  { 'vim-suda', lazy = false },
}
