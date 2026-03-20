return {
  {
    'nvchad-ui',
    dep_of = { 'base46' },
    after = function()
      require 'nvchad'
      require('nvchad.lsp').diagnostic_config()

      local set = vim.keymap.set
      if require('nvconfig').ui.tabufline.enabled then
        set('n', '<leader>b', '<cmd> enew <CR>', { desc = 'buffer new' })
        set('n', '<tab>', function()
          require('nvchad.tabufline').next()
        end, { desc = 'buffer goto next' })
        set('n', '<S-Tab>', function()
          require('nvchad.tabufline').prev()
        end, { desc = 'buffer goto prev' })
        set('n', '<leader>x', function()
          require('nvchad.tabufline').close_buffer()
        end, { desc = 'buffer close' })
      end
    end,
  },

  {
    'base46',
    event = 'UIEnter',
    after = function()
      for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
        dofile(vim.g.base46_cache .. v)
      end
    end,
  },

  {
    'nvim-web-devicons',
    on_plugin = 'nvchad-ui',
    after = function()
      require('nvim-web-devicons').setup {
        override = require 'nvchad.icons.devicons',
      }
    end,
  },

  {
    'blink.indent',
    lazy = false,
    after = function()
      require('blink.indent').setup {
        static = { char = '│', highlights = { 'BlinkIndent' } },
        scope = { enabled = false },
      }
    end,
  },

  {
    'nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    after = function()
      require('nvim-tree').setup {
        on_attach = function(bufnr)
          local api = require 'nvim-tree.api'
          api.map.on_attach.default(bufnr)

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr }
          end

          local set = vim.keymap.set
          set('n', 'y', api.fs.copy.node, opts 'Copy')
          set('n', 'c', api.fs.create, opts 'Create File Or Directory')
        end,

        filters = { dotfiles = false },
        disable_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
        },
        view = {
          width = 30,
          preserve_window_proportions = true,
        },
        renderer = {
          root_folder_label = false,
          highlight_git = 'all',
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              default = '󰈚',
              folder = {
                default = '󰉋',
                empty = '󰉖',
                empty_open = '󰷏',
                open = '󰝰',
                symlink = '󱉆',
              },
              git = { unmerged = '' },
            },
          },
        },
      }
    end,
  },

  {
    'which-key.nvim',
    keys = { '<leader>', '<c-w>', '"', "'", '`', 'c', 'v', 'g' },
    cmd = 'WhichKey',
    opts = function()
      require('which-key').setup {}

      local set = vim.keymap.set
      set('n', '<leader>wK', '<cmd> WhichKey <CR>', { desc = 'whichkey all keymaps' })
      set('n', '<leader>wk', function()
        vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
      end, { desc = 'whichkey query lookup' })
    end,
  },
}
