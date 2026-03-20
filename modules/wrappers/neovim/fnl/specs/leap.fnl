(local {: autoload} (require :nfnl.module))

(fn clever []
  (fn as-ft [specific]
    (let [safe_labels (if (: (vim.fn.mode 1) :match "[no]") "" nil)
          common {:inputlen 1 :inclusive true :opts {:labels "" : safe_labels}}]
      (vim.tbl_deep_extend :keep common specific)))

  (let [{: leap} (autoload :leap)
        clever (. (autoload :leap.user) :with_traversal_keys)
        clever-f (clever :f :F)
        clever-t (clever :t :T)
        keys {:f {:opts clever-f}
              :F {:backward true :opts clever-f}
              :t {:offset -1 :opts clever-t}
              :T {:backward true :offset 1 :opts clever-t}}]
    (each [key specific (pairs keys)]
      (vim.keymap.set [:n :x :o] key #(leap (as-ft specific))))))

(fn after []
  (vim.keymap.set [:n :x :o] :s "<Plug>(leap)" {:desc "leap leap"})
  (vim.keymap.set :n :S "<Plug>(leap-from-window)"
                  {:desc "leap leap from window"})
  (clever))

[{1 :vim-repeat :event :DeferredUIEnter} {1 :leap.nvim :lazy false : after}]
