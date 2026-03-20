(local {: autoload} (require :nfnl.module))

{1 :guess-indent.nvim
 :lazy false
 :after #((. (autoload :guess-indent) :setup) {})}
