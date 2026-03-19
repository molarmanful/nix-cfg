return {
  { 'marksman', lsp = { filetypes = { 'markdown', 'markdown.mdx' } } },

  {
    'render-markdown.nvim',
    event = 'UIEnter',
    ft = { 'markdown', 'rmd', 'norg', 'org' },
  },

  {
    'obsidian.nvim',
    enabled = function()
      return vim.fs.root(0, '.obsidian')
    end,
    ft = 'markdown',
    after = function()
      require('obsidian').setup {
        legacy_commands = false,
        ui = { enable = false },
        frontmatter = { enabled = false },
        footer = { enabled = false },
        callbacks = {
          enter_note = function(note)
            vim.api.nvim_buf_call(note.bufnr, function()
              vim.cmd 'Obsidian open'
            end)
          end,
        },
        workspaces = {
          {
            name = 'auto',
            path = function()
              return vim.fs.root(0, '.obsidian')
            end,
          },
        },
      }
    end,
  },
}
