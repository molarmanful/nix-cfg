(local {: autoload} (require :nfnl.module))

{1 :nvchad-ui
 :dep_of [:base46]
 :after (fn []
          (require :nvchad)
          (. (autoload :nvchad.lsp) :diagnostic_config)
          (vim.keymap.set :n :<leader>ch "<cmd> NvCheatsheet <CR>"
                          {:desc "toggle nvcheatsheet"})
          (when (. (autoload :nvconfig) :ui :tabufline :enabled)
            (let [tbl (autoload :nvchad.tabufline)]
              (vim.keymap.set :n :<leader>b "<cmd> enew <CR>"
                              {:desc "buffer new"})
              (vim.keymap.set :n :<Tab> tbl.next {:desc "buffer goto next"})
              (vim.keymap.set :n :<S-Tab> tbl.prev {:desc "buffer goto prev"})
              (vim.keymap.set :n :<leader>x tbl.close_buffer
                              {:desc "buffer close"}))))}
