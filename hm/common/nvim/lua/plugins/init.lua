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
  'vtsls',
  'emmet_language_server',
  'nixd',
  'nushell',
  'gdscript',
  'biome',
}

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
    'lukas-reineke/indent-blankline.nvim',
    opts = { scope = { enabled = false } },
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

  {
    'julienvincent/hunk.nvim',
    cmd = { 'DiffEditor' },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },

  {
    'rafikdraoui/jj-diffconflicts',
    cmd = { 'JJDiffConflicts' },
  },
}
