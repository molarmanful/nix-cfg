local lsps = {
  'lua_ls',
  'html',
  'svelte',
  'unocss',
  'eslint',
  'bashls',
  'marksman',
  'rust_analyzer',
  'stylelint_lsp',
  'dockerls',
  'yamlls',
  'tailwindcss',
  'unocss',
  'hls',
  'gopls',
  'clangd',
  'clojure_lsp',
  'perlnavigator',
  'markdown_oxide',
  'vtsls',
  'emmet_language_server',
  'nil_ls',
  'nixd',
  'nushell',
  'gdscript',
}

local syns = {
  'comment',
}

return {

  { 'williamboman/mason.nvim', enabled = false },
  { 'williamboman/mason-lspconfig.nvim', enabled = false },

  {
    'neovim/nvim-lspconfig',
    config = function()
      require('nvchad.configs.lspconfig').defaults()
      require 'configs.lspconfig'(lsps)
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = require 'configs.conform',
  },

  {
    'nvimtools/none-ls.nvim',
    config = function()
      require 'configs.null-ls'
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
    'hrsh7th/nvim-cmp',
    config = function()
      require 'configs.cmp'
    end,
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
    opts = require 'configs.telescope',
  },

  {
    'nvim-telescope/telescope-file-browser.nvim',
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },

  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    'ggandor/flit.nvim',
    lazy = false,
    opts = {},
  },

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
    'NvChad/nvterm',
    opts = {
      behavior = {
        auto_insert = false,
      },
    },
  },

  {
    'gpanders/nvim-parinfer',
    ft = { 'clojure', 'scheme', 'lisp' },
  },

  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'python' },
    dependencies = {
      'PaterJason/cmp-conjure',
    },
    config = function()
      require('conjure.main').main()
      require('conjure.mapping')['on-filetype']()
    end,
  },

  {
    'lukas-reineke/headlines.nvim',
    ft = { 'markdown', 'rmd', 'norg', 'org' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },

  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    branch = 'master',
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
}
