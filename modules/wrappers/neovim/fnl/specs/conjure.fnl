{1 :conjure
 :ft [:clojure :fennel :lua :python]
 :before (fn []
           (set vim.g.conjure#mapping#doc_word :K)
           (set vim.g.conjure#def_word :gd))}
