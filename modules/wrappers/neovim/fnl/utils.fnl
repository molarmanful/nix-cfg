(local M {})

(set M.lisps [:clojure :fennel :scheme :lisp :janet])

(fn M.barrel [base names]
  (icollect [_ name (ipairs names)]
    {:import (.. (if base (.. base ".") "") name)}))

M
