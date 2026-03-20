(local {: autoload} (require :nfnl.module))

[{1 :diffview.nvim :dep_of [:neogit]}
 {1 :neogit
  :cmd :Neogit
  :beforeAll #(vim.keymap.set :n :<leader>go "<cmd> Neogit <CR>"
                              {:desc "neogit open neogit"})
  :after #((. (autoload :neogit) :setup) {})}]
