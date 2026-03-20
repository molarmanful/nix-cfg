(local {: autoload} (require :nfnl.module))

(fn after [{: ft}]
  (let [{:bare_config config : initialize_or_attach} (autoload :metals)]
    (set config.settings {:showImplicitArguments true})
    (local group (vim.api.nvim_create_augroup :nvim-metals {:clear true}))
    (vim.api.nvim_create_autocmd :FileType
                                 {:pattern ft
                                  :callback (fn []
                                              (initialize_or_attach config)
                                              nil)
                                  : group})))

[{1 :nvim-metals :ft [:scala :sbt :java] : after}]
