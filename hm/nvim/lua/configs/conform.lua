return {
  format_on_save = {
    lsp_fallback = true,
  },

  formatters_by_ft = {
    lua = { 'stylua' },
    css = { 'prettier' },
    html = { 'prettier' },
    svelte = { 'prettier' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    python = { 'black' },
    go = { 'golines' },
    sh = { 'shfmt' },
    fish = { 'fish_indent' },
    gdscript = { 'gdformat' },
    sql = { 'sqlfmt' },
    yaml = { 'yamlfix' },
    clojure = { 'zprint' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    nix = { 'nixfmt' },
    nu = { 'nufmt' },
    toml = { 'taplo' },
  },

  formatters = {
    gdformat = {
      prepend_args = { '--line-length', '80' },
    },
  },
}
