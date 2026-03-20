return {
  {
    'vtsls',
    lsp = {
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte' },
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          tsserver = {
            globalPlugins = {
              {
                name = 'typescript-svelte-plugin',
                location = '',
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = 'always' },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
      },
    },
  },

  {
    'biome',
    lsp = {
      filetypes = {
        'astro',
        'css',
        'graphql',
        'html',
        'javascript',
        'javascriptreact',
        'json',
        'jsonc',
        'svelte',
        'typescript',
        'typescriptreact',
        'vue',
      },
    },
  },

  {
    'eslint',
    lsp = {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'svelte',
        'astro',
        'htmlangular',
      },
    },
  },

  {
    'html',
    lsp = {
      filetypes = { 'html' },
      init_options = { provideFormatter = false },
    },
  },

  { 'svelte', lsp = { filetypes = { 'svelte' } } },

  {
    'tailwindcss',
    lsp = {
      filetypes = {
        'aspnetcorerazor',
        'astro',
        'astro-markdown',
        'blade',
        'clojure',
        'django-html',
        'htmldjango',
        'edge',
        'eelixir',
        'elixir',
        'ejs',
        'erb',
        'eruby',
        'gohtml',
        'gohtmltmpl',
        'haml',
        'handlebars',
        'hbs',
        'html',
        'htmlangular',
        'html-eex',
        'heex',
        'jade',
        'leaf',
        'liquid',
        'markdown',
        'mdx',
        'mustache',
        'njk',
        'nunjucks',
        'php',
        'razor',
        'slim',
        'twig',
        'css',
        'less',
        'postcss',
        'sass',
        'scss',
        'stylus',
        'sugarss',
        'javascript',
        'javascriptreact',
        'reason',
        'rescript',
        'typescript',
        'typescriptreact',
        'vue',
        'svelte',
        'templ',
      },
    },
  },

  {
    'unocss',
    lsp = {
      filetypes = {
        'erb',
        'haml',
        'hbs',
        'html',
        'css',
        'postcss',
        'javascript',
        'javascriptreact',
        'markdown',
        'ejs',
        'php',
        'svelte',
        'typescript',
        'typescriptreact',
        'vue-html',
        'vue',
        'sass',
        'scss',
        'less',
        'stylus',
        'astro',
        'rescript',
        'rust',
      },
    },
  },

  {
    'nvim-ts-autotag',
    lazy = false,
    after = function()
      require('nvim-ts-autotag').setup {}
    end,
  },
}
