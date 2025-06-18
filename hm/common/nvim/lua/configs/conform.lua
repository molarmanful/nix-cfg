return {
  format_on_save = {
    lsp_fallback = true,
  },

  formatters_by_ft = {
    lua = { 'stylua' },
    css = { 'dprint', 'prettier' },
    html = { 'dprint', 'prettier' },
    svelte = { 'dprint', 'prettier' },
    vue = { 'dprint', 'prettier' },
    javascript = { 'dprint', 'prettier' },
    typescript = { 'dprint', 'prettier' },
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
    go = { 'golines' },
    sh = { 'shfmt' },
    fish = { 'fish_indent' },
    gdscript = { 'gdformat' },
    sql = { 'sqlfmt' },
    yaml = { 'yamlfmt', 'dprint' },
    clojure = { 'zprint' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    nix = { 'nixfmt' },
    nu = { 'nufmt' },
    toml = { 'taplo', 'dprint' },
    markdown = { 'mdformat', 'dprint' },
    rust = { 'rustfmt' },
    haskell = { 'fourmolu' },
    cabal = { 'cabal_fmt' },
    json = { 'dprint' },
  },

  formatters = {
    gdformat = {
      prepend_args = { '--line-length', '80' },
    },
  },
}
