(local {: autoload} (require :nfnl.module))

(fn after []
  (fn on_attach [bufnr]
    (let [gitsigns (autoload :gitsigns)]
      (fn opts [desc]
        {:desc (.. "gitsigns: " desc) :buffer bufnr})

      (vim.keymap.set :n :<leader>gk #(gitsigns.nav_hunk :prev)
                      (opts "prev hunk"))
      (vim.keymap.set :n :<leader>gj #(gitsigns.nav_hunk :next)
                      (opts "next hunk"))
      (vim.keymap.set :n :<leader>ghr gitsigns.reset_hunk (opts "reset hunk"))
      (vim.keymap.set :v :<leader>ghr
                      #(gitsigns.reset_hunk [(vim.fn.line ".")
                                             (vim.fn.line :v)])
                      (opts "reset hunk"))))

  (let [{: setup} (autoload :gitsigns)]
    (setup {:signs {:delete {:text "󰍵"} :changedelete {:text "󰛲"}}
            : on_attach})))

[{1 :gitsigns.nvim
  :event [:BufReadPost :BufNewFile]
  :after #(vim.schedule after)}]
