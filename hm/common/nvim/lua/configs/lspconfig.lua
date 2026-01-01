require('nvchad.configs.lspconfig').defaults()

local default_on_attach = vim.lsp.config['*'].on_attach

local overrides = {
  ['*'] = {
    on_attach = function(client, bufnr)
      if not default_on_attach then
        return
      end
      default_on_attach(client, bufnr)
    end,
  },

  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        },
      },
    },
  },

  vtsls = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'svelte',
    },
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

  html = {
    init_options = {
      provideFormatter = false,
    },
  },

  gdscript = {
    cmd = os.getenv 'WSL_DISTRO_NAME' and { 'godot-wsl-lsp', '--useMirroredNetworking', '--host', '127.0.0.1' },
  },

  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        check = { command = 'clippy' },
      },
    },
  },
}

return function(lsps)
  for _, lsp in ipairs(lsps) do
    vim.lsp.config(lsp, overrides[lsp] or {})
    vim.lsp.enable(lsp)
  end
end
