(set _G.nixInfo (require vim.g.nix_info_plugin_name))
(local {: nixInfo} _G)

(set nixInfo.lze
     (setmetatable (require :lze) (getmetatable (require :lzextras))))

(fn nixInfo.get_nix_plugin_path [name]
  (or (nixInfo nil :plugins :lazy name) (nixInfo nil :plugins :start name)))

(nixInfo.lze.register_handlers [nixInfo.lze.lsp])

(fn lsp-ft [name]
  (let [lspcfg (nixInfo.get_nix_plugin_path :nvim-lspconfig)
        cfg (if lspcfg
                (let [(_ cfg) (pcall dofile (.. lspcfg :/lsp/ name :.lua))]
                  cfg)
                (?. vim.lsp.config name))]
    (or (?. cfg :filetypes) [])))

(nixInfo.lze.h.lsp.set_ft_fallback lsp-ft)

(set vim.g.base46_cache (.. (nixInfo.get_nix_plugin_path :base46) :/cache/))
