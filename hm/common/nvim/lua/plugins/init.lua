local syns = {
  'comment',
}

return {
  {
    'nvchad/base46',
    branch = 'v3.0',
    build = function()
      require('base46').load_all_highlights()
    end,
  },
  { import = 'nvchad.blink.lazyspec' },

  { 'williamboman/mason.nvim', enabled = false },
  { 'williamboman/mason-lspconfig.nvim', enabled = false },

  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'configs.lspconfig'
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    event = { 'User FilePost' },
    config = function()
      require 'configs.null-ls'
    end,
  },

  {
    'lukas-reineke/lsp-format.nvim',
    event = { 'User FilePost' },
    config = function()
      require 'configs.lsp-format'
    end,
  },

  {
    'scalameta/nvim-metals',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    ft = { 'scala', 'sbt', 'java' },
    config = require 'configs.nvim-metals',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      auto_install = true,
      ensure_installed = syns,
      indent = {
        disable = { 'markdown' },
      },
    },
  },

  {
    'windwp/nvim-ts-autotag',
    lazy = false,
    opts = {},
  },

  {
    'Saghen/blink.cmp',
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<S-Tab>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'hide', 'fallback' },
      },
    },
  },

  {
    'olimorris/persisted.nvim',
    priority = 100,
    lazy = false,
    opts = {
      use_git_branch = true,
      autoload = true,
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require 'configs.telescope'
    end,
  },

  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },

  {
    'https://codeberg.org/andyg/leap.nvim',
    lazy = false,
  },

  { 'tpope/vim-repeat', event = 'VeryLazy' },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim',
    },
    config = true,
  },

  {
    'gpanders/nvim-parinfer',
    ft = { 'clojure', 'scheme', 'lisp' },
  },

  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel' },
    dependencies = {
      'PaterJason/cmp-conjure',
    },
    config = function()
      require('conjure.main').main()
      require('conjure.mapping')['on-filetype']()
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'rmd', 'norg', 'org' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = { scope = { enabled = false } },
  },

  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    ft = 'markdown',
    cond = function()
      return vim.fs.root(0, '.obsidian')
    end,
    opts = {
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
    },
  },

  {
    'lambdalisue/vim-suda',
    lazy = false,
  },

  {
    'nmac427/guess-indent.nvim',
    opts = {},
    lazy = false,
  },

  {
    'rafikdraoui/jj-diffconflicts',
    cmd = { 'JJDiffConflicts' },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    config = function()
      require 'rustaceanvim'
    end,
  },
}
