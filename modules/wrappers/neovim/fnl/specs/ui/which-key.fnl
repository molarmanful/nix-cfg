(local {: autoload} (require :nfnl.module))

(fn beforeAll []
  (vim.keymap.set :n :<leader>wK "<cmd> WhichKey <CR>"
                  {:desc "whichkey all keymaps"})
  (vim.keymap.set :n :<leader>wk
                  #(vim.cmd (.. "WhichKey " (vim.fn.input "WhichKey: ")))
                  {:desc "whichkey query lookup"}))

{1 :which-key.nvim
 :keys [:<leader> :<localleader> :<c-w> "\"" "'" "`" :c :v :g]
 :cmd :WhichKey
 : beforeAll
 :after #((. (autoload :which-key) :setup) {})}
