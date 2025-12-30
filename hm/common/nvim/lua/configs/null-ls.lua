local null_ls = require 'null-ls'

local form = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

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
    form.clang_format,
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

  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
