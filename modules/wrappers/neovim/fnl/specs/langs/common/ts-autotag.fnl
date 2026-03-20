(local {: autoload} (require :nfnl.module))

{1 :nvim-ts-autotag
 :lazy false
 :after #((. (autoload :nvim-ts-autotag) :setup) {})}
