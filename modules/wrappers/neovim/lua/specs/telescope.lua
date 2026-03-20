return {
  {
    'telescope.nvim',
    event = 'DeferredUIEnter',
    after = function()
      local telescope = require 'telescope'

      telescope.setup {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = ' ',
          entry_prefix = ' ',
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            n = {
              ['q'] = require('telescope.actions').close,
            },
            i = {
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
          },
        },
        extensions_list = { 'themes', 'terms', 'persisted', 'fzf', 'ui-select', 'file_browser' },
      }

      local set = vim.keymap.set
      set('n', '<leader>fw', '<cmd> Telescope live_grep <CR>', { desc = 'telescope live grep' })
      set('n', '<leader>fb', '<cmd> Telescope buffers <CR>', { desc = 'telescope find buffers' })
      set('n', '<leader>fh', '<cmd> Telescope help_tags <CR>', { desc = 'telescope help page' })
      set('n', '<leader>ma', '<cmd> Telescope marks <CR>', { desc = 'telescope find marks' })
      set('n', '<leader>fo', '<cmd> Telescope oldfiles <CR>', { desc = 'telescope find oldfiles' })
      set(
        'n',
        '<leader>fz',
        '<cmd> Telescope current_buffer_fuzzy_find <CR>',
        { desc = 'telescope find in current buffer' }
      )
      set('n', '<leader>pt', '<cmd> Telescope terms <CR>', { desc = 'telescope pick hidden term' })
      set('n', '<leader>ff', '<cmd> Telescope file_browser hidden=true <CR>', { desc = 'telescope file browser' })
      set(
        'n',
        '<leader>fr',
        '<cmd> Telescope file_browser hidden=true path=%:p:h <CR>',
        { desc = 'telescope file browser (relative)' }
      )
      set(
        'n',
        '<leader>fa',
        '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>',
        { desc = 'telescope find all files' }
      )
      set('n', '<leader>fs', '<cmd> Telescope persisted <CR>', { desc = 'telescope find session' })
      set('n', '<leader>fx', '<cmd> Telescope lsp_document_symbols <CR>', { desc = 'telescope find LSP symbol' })
      set('n', '<leader>fX', '<cmd> Telescope lsp_workspace_symbols <CR>', { desc = 'telescope find LSP symbol' })
      set(
        'n',
        '<leader>q',
        '<cmd> Telescope diagnostics bufnr=0 <CR>',
        { desc = 'telescope show buffer LSP diagnostics' }
      )
      set('n', '<leader>Q', '<cmd> Telescope diagnostics <CR>', { desc = 'telescope show project LSP diagnostics' })
    end,
  },

  { 'telescope-fzf-native.nvim', on_plugin = { 'telescope.nvim' } },
  { 'telescope-ui-select.nvim', on_plugin = { 'telescope.nvim' } },
  { 'telescope-file-browser.nvim', on_plugin = { 'telescope.nvim' } },
}
