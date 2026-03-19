return {
  {
    'nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
    before = function()
      vim.lsp.config('*', {
        on_attach = function(_, bufnr)
          local set = vim.keymap.set
          local function opts(desc)
            return { buffer = bufnr, desc = 'LSP ' .. desc }
          end

          set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts 'add workspace folder')
          set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts 'remove workspace folder')
          set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts 'list workspace folders')
          set('n', '<leader>ra', require 'nvchad.lsp.renamer', opts 'NvRenamer')

          set('n', '<leader>lf', vim.diagnostic.open_float, opts 'lspconfig floating diagnostic')
          set('n', '[d', function()
            vim.diagnostic.jump { count = -1, float = {} }
          end, opts 'lspconfig goto prev')
          set('n', ']d', function()
            vim.diagnostic.jump { count = 1, float = {} }
          end, opts 'lspconfig goto next')
          set('n', 'gd', '<cmd> Telescope lsp_definitions <CR>', opts 'telescope find LSP definitions')
          set('n', 'gD', '<cmd> Telescope lsp_type_definitions <CR>', opts 'telescope find LSP definitions')
          set('n', 'grr', '<cmd> Telescope lsp_references <CR>', opts 'telescope find LSP references')
        end,

        on_init = function(client, _)
          if client:supports_method 'textDocument/semanticTokens' then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    after = function()
      require('nvim-treesitter').setup {}
      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  {
    'none-ls.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    after = function()
      local null_ls = require 'null-ls'

      local form = null_ls.builtins.formatting
      local lint = null_ls.builtins.diagnostics

      null_ls.setup {
        sources = {
          form.stylua,
          form.prettierd,
          form.golines,
          form.shfmt,
          form.shellharden,
          form.fish_indent,
          form.gdformat,
          form.sqlfmt,
          form.yamlfmt,
          form.zprint,
          form.clang_format.with {
            extra_filetypes = { 'gdshader' },
          },
          form.nixfmt,
          form.mdformat,
          form.mix,

          lint.selene,
          lint.fish,
          lint.gdlint,
          lint.yamllint,
          lint.hadolint,
          lint.actionlint,
          lint.statix,
          lint.deadnix,
          lint.staticcheck,
          lint.credo,
        },
      }
    end,
  },

  {
    'lsp-format.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    after = function()
      local lf = require 'lsp-format'

      local supported = { 'null-ls', 'dprint', 'ruff', 'taplo', 'biome', 'rust-analyzer', 'metals' }

      local config = {}
      for _, v in pairs(vim.fn.getcompletion('', 'filetype')) do
        config[v] = { sync = true }
      end
      lf.setup(config)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if client.name == 'eslint' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              command = 'LspEslintFixAll',
            })
          elseif vim.tbl_contains(supported, client.name) then
            lf.on_attach(client, args.buf)
          end
        end,
      })
    end,
  },

  { 'hls', lsp = { filetypes = { 'haskell', 'lhaskell', 'cabal' } } },

  { 'gopls', lsp = { filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' } } },

  { 'clangd', lsp = { filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' } } },

  { 'gdscript', lsp = { filetypes = { 'gd', 'gdscript', 'gdscript3' } } },

  { 'elixirls', lsp = { filetypes = { 'elixir', 'eelixir', 'heex', 'surface' } } },

  {
    'dprint',
    lsp = {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'jsonc',
        'markdown',
        'python',
        'toml',
        'rust',
        'roslyn',
        'graphql',
        'svelte',
      },
    },
  },

  { import = 'specs.langs.cfg' },
  { import = 'specs.langs.lisp' },
  { import = 'specs.langs.lua' },
  { import = 'specs.langs.markdown' },
  { import = 'specs.langs.nix' },
  { import = 'specs.langs.py' },
  { import = 'specs.langs.rust' },
  { import = 'specs.langs.scala' },
  { import = 'specs.langs.shell' },
  { import = 'specs.langs.web' },
}
