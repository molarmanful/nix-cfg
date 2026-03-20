(fn after []
  (fn on_attach [_ bufnr]
    (vim.keymap.set :n :gra #(vim.cmd.RustLsp :codeAction)
                    {:desc "lsp Code actions" :buffer bufnr}))

  (let [rust-analyzer {:cargo {:allFeatures true
                               :loadOutDirsFromCheck true
                               :buildScripts {:enable true}}
                       :checkOnSave true
                       :diagnostics {:enable true}
                       :procMacro {:enable true}
                       :files {:watcher :client
                               :exclude [:.direnv
                                         :.git
                                         :.jj
                                         :.github
                                         :.gitlab
                                         :bin
                                         :node_modules
                                         :target
                                         :venv
                                         :.venv]}}]
    (set vim.g.rustaceanvim
         (vim.tbl_deep_extend :keep (or vim.g.rustaceanvim {})
                              {:server {: on_attach
                                        :default_settings {: rust-analyzer}}}))))

[{1 :rustaceanvim :lazy false : after}]
