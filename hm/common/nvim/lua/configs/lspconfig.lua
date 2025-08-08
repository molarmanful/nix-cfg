local lspconfig = require 'lspconfig'

local configs = require 'nvchad.configs.lspconfig'
local on_init = configs.on_init
local on_attach = function(client, bufnr)
  configs.on_attach(client, bufnr)
  require 'util.lspkeys'(bufnr)
end
local capabilities = configs.capabilities

return function(lsps)
  local overrides = {
    yamlls = {
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
          },
        },
      },
    },

    eslint = {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    },

    emmet_language_server = {
      filetypes = { 'svelte' },
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

    nixd = {
      settings = {
        nixd = {
          nixpkgs = {
            expr = 'import (builtins.getFlake "git+file://${toString ./.}").inputs.nixpkgs { }',
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake "git+file://${toString ./.}").nixosConfigurations.loqnux.options',
            },
            flake_parts = {
              expr = 'let flake = builtins.getFlake "git+file://${toString ./.}"; in flake.debug.options // flake.currentSystem.options',
            },
          },
        },
      },
    },
  }

  for _, lsp in ipairs(lsps) do
    local res = {
      on_init = on_init,
      on_attach = on_attach,
      capabilities = capabilities,
    }
    for k, v in pairs(overrides[lsp] or {}) do
      res[k] = v
    end
    lspconfig[lsp].setup(res)
  end
end
