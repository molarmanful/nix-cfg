(local {: autoload} (require :nfnl.module))
(local {: map : identity : assoc} (autoload :nfnl.core))

{1 :blink.indent
 :lazy false
 :after #(let [{: setup} (autoload :blink.indent)
               {: lisps} (autoload :utils)
               filetypes (assoc (map identity lisps) :include_defaults true)]
           (setup {:blocked {: filetypes}
                   :static {:char "│" :highlights [:BlinkIndent]}
                   :scope {:enabled false}}))}
