(local {: autoload} (require :nfnl.module))

(fn after []
  (let [null-ls (autoload :null-ls)
        form null-ls.builtins.formatting
        lint null-ls.builtins.diagnostics
        sources [form.stylua
                 form.prettierd
                 form.golines
                 form.shfmt
                 form.shellharden
                 form.fish_indent
                 form.gdformat
                 form.sqlfmt
                 form.yamlfmt
                 form.zprint
                 (form.clang_format.with {:extra_filetypes [:gdshader]})
                 form.nixfmt
                 form.mdformat
                 form.mix
                 form.fnlfmt
                 lint.selene
                 lint.fish
                 lint.gdlint
                 lint.yamllint
                 lint.hadolint
                 lint.actionlint
                 lint.statix
                 lint.deadnix
                 lint.staticcheck
                 lint.credo]]
    (null-ls.setup {: sources})))

{1 :none-ls.nvim :event [:BufReadPost :BufNewFile] : after}
