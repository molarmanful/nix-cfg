local null_ls = require 'null-ls'

local form = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

null_ls.setup {
  sources = {
    form.stylua,
    form.prettierd,
    form.golines,
    form.shfmt,
    form.shellharden,
    form.fish_indent,
    form.gdformat,
    form.sqlfmt,
    form.yamlfmt,
    form.zprint,
    form.clang_format.with {
      extra_filetypes = { 'gdshader' },
    },
    form.nixfmt,
    form.mdformat,
    form.mix,

    lint.selene,
    lint.fish,
    lint.gdlint,
    lint.markdownlint,
    lint.yamllint,
    lint.hadolint,
    lint.actionlint,
    lint.statix,
    lint.deadnix,
    lint.staticcheck,
    lint.credo,
  },
}
