require('nvchad.configs.lspconfig').defaults()

local default_on_attach = vim.lsp.config['*'].on_attach
local eslint_on_attach = vim.lsp.config.eslint.on_attach

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

  eslint = {
    on_attach = function(client, bufnr)
      if not eslint_on_attach then
        return
      end
      eslint_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'LspEslintFixAll',
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

return function(lsps)
  for _, lsp in ipairs(lsps) do
    vim.lsp.config(lsp, overrides[lsp] or {})
    vim.lsp.enable(lsp)
  end
end
