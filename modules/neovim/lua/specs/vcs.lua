return {
  { 'diffview.nvim', dep_of = { 'neogit' } },

  {
    'gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      vim.schedule(function()
        require('gitsigns').setup {
          signs = {
            delete = { text = '󰍵' },
            changedelete = { text = '󰛲' },
          },
        }
      end)
    end,
  },

  {
    'neogit',
    cmd = 'Neogit',
    after = function()
      require('neogit').setup {}
    end,
  },

  { 'jj-diffconflicts', cmd = { 'JJDiffConflicts' } },
}
