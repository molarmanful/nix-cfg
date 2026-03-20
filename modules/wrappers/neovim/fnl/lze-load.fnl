(local {: autoload} (require :nfnl.module))
(local fs (autoload :nfnl.fs))
(local {: nixInfo} _G)

(local cfg-dir (fs.absglob nixInfo.settings.config_directory
                           :lua/specs/**/*.lua))

(local specs (icollect [_ f (ipairs cfg-dir)] (dofile f)))

(nixInfo.lze.load specs)
