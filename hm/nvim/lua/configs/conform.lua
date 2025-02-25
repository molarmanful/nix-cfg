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
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
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
    markdown = { 'mdformat' },
    rust = { 'rustfmt' },
  },

  formatters = {
    gdformat = {
      prepend_args = { '--line-length', '80' },
    },
  },
}
