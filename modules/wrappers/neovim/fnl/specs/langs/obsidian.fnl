(local {: autoload} (require :nfnl.module))

(fn root [] (vim.fs.root 0 :.obsidian))

(fn after []
  (let [{: setup} (autoload :obsidian)]
    (setup {:legacy_commands false
            :ui {:enable false}
            :frontmatter {:enabled false}
            :footer {:enabled false}
            :workspaces [{:name :auto :path root}]
            :callbacks {:enter_note (fn [{: bufnr}]
                                      (vim.api.nvim_buf_call bufnr
                                                             #(vim.cmd "Obsidian open")))}})))

{1 :obsidian.nvim :enabled root :ft [:markdown] : after}
