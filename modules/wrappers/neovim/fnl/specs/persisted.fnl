(local {: autoload} (require :nfnl.module))

{1 :persisted.nvim
 :lazy false
 :after #(let [{: setup} (autoload :persisted)]
           (setup {:use_git_branch true :autoload true}))}
