(local {: autoload} (require :nfnl.module))
(local {: concat} (autoload :nfnl.core))

(fn after []
  (let [{: setup} (autoload :nvim-autopairs)
        {: lisps} (autoload :utils)]
    (setup {:fast_wrap {}
            :disable_filetype (concat lisps [:TelescopePrompt :vim])})))

{1 :nvim-autopairs :dep_of [:blink.cmp] : after}
