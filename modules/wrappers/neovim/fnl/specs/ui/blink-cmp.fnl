(local {: autoload} (require :nfnl.module))

{1 :blink.cmp
 :event [:InsertEnter :CmdLineEnter]
 :after #(let [{: setup} (autoload :blink.cmp)
               {: menu} (autoload :nvchad.blink)]
           (setup {:snippets {:preset :luasnip}
                   :cmdline {:enabled true}
                   :appearance {:nerd_font_variant :normal}
                   :fuzzy {:implementation :prefer_rust}
                   :signature {:enabled true}
                   :sources {:default [:lsp :snippets :buffer :path]}
                   :keymap {:preset :default
                            :<Tab> [:select_and_accept :fallback]
                            :<C-j> [:select_next :fallback]
                            :<C-k> [:select_prev :fallback]
                            :<S-Tab> [:hide :fallback]
                            :<CR> [:hide :fallback]}
                   :completion {: menu
                                :accept {:auto_brackets {:enabled true}}
                                :documentation {:auto_show true
                                                :auto_show_delay_ms 200
                                                :window {:border :single}}}}))}
