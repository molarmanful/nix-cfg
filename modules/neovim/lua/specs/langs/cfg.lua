return {
  {
    'yamlls',
    lsp = {
      filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
          },
        },
      },
    },
  },

  { 'taplo', lsp = { filetypes = { 'toml' } } },
}
