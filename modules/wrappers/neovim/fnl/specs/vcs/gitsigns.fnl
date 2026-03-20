(local {: autoload} (require :nfnl.module))

[{1 :gitsigns.nvim
  :event [:BufReadPost :BufNewFile]
  :after #(vim.schedule #(let [{: setup} (autoload :gitsigns)]
                           (setup {:signs {:delete {:text "󰍵"}
                                           :changedelete {:text "󰛲"}}})))}]
