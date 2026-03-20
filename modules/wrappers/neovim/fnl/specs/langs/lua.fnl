(local {: autoload} (require :nfnl.module))
(local {: nixInfo} _G)

(fn after []
  (let [{: setup} (autoload :lazydev)]
    (setup {:library [{:words ["nixInfo%.lze"]
                       :path (.. (nixInfo :lze :plugins :start :lze) :/lua)}
                      {:words ["nixInfo%.lze"]
                       :path (.. (nixInfo :lzextras :plugins :start :lzextras)
                                 :/lua)}]})))

[{1 :lua_ls :lsp {:filetypes [:lua]}}
 {1 :lazydev.nvim :ft [:lua] :cmd [:LazyDev] : after}]
