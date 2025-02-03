local null_ls = require 'null-ls'

local lint = null_ls.builtins.diagnostics
local act = null_ls.builtins.code_actions

null_ls.setup {
  debug = true,
  sources = {

    lint.selene,
    lint.fish,
    lint.gdlint,
    lint.pylint,
    lint.markdownlint,
    lint.shellharden,
    lint.yamllint,
    lint.hadolint,
    lint.actionlint,
    lint.perlimports,
    lint.deadnix,
    lint.staticcheck,

    act.gitsigns,
    act.statix,
  },
  -- on_attach = require 'util.saveform',
}
