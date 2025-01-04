return {
  format_on_save = {
    lsp_fallback = true,
  },

  formatters_by_ft = {
    lua = { 'stylua' },
    css = { 'prettierd' },
    html = { 'prettierd' },
    svelte = { 'prettierd' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
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
  },

  formatters = {
    golines = {
      args = { '--base-formatter', 'gci', '--', '$FILENAME' },
    },
    gdformat = {
      args = { '--line-length', '80' },
    },
  },
}
