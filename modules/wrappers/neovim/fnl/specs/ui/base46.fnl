[{1 :base46
  :event :UIEnter
  :after #(each [_ v (ipairs (vim.fn.readdir vim.g.base46_cache))]
            (dofile (.. vim.g.base46_cache v)))}]
