return {
  {
    'nil_ls',
    lsp = {
      filetypes = { 'nix' },
      settings = {
        nil_ls = {
          formatting = { 'nixfmt' },
          nix = {
            flake = {
              autoEvalInputs = false,
            },
          },
        },
      },
    },
  },
}
