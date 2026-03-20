(local {: autoload} (require :nfnl.module))

[{1 :nvim-web-devicons
  :on_plugin [:nvchad-ui]
  :after #(let [{: setup} (autoload :nvim-web-devicons)]
            (setup {:override {:default_icon {:icon "󰈚" :name :Default}
                               :js {:icon "󰌞" :name :js}
                               :ts {:icon "󰛦" :name :ts}
                               :lock {:icon "󰌾" :name :lock}
                               :robots.txt {:icon "󰚩" :name :robots}}}))}]
