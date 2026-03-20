(local {: autoload} (require :nfnl.module))

[{1 :friendly-snippets :dep_of [:luasnip :blink.cmp]}
 {1 :luasnip
  :dep_of [:blink.cmp]
  :after #(let [ls (autoload :luasnip)
                fv (autoload :luasnip.loaders.from_vscode)
                fs (autoload :luasnip.loaders.from_snipmate)
                fl (autoload :luasnip.loaders.from_lua)]
            (ls.config.set_config {:history true
                                   :updateevents "TextChanged,TextChangedI"})
            (fv.lazy_load {:exclude (or vim.g.vscode_snippets_exclude {})})
            (fv.lazy_load {:paths (or vim.g.vscode_snippets_path "")})
            (fs.load)
            (fs.lazy_load {:paths (or vim.g.snipmate_snippets_path "")})
            (fl.load)
            (fl.lazy_load {:paths (or vim.g.lua_snippets_path "")}))}]
