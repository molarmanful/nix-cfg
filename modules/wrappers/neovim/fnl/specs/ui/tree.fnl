(local {: autoload} (require :nfnl.module))

(fn beforeAll []
  (vim.keymap.set :n :<C-n> "<cmd> NvimTreeToggle <CR>"
                  {:desc "nvimtree toggle window"})
  (vim.keymap.set :n :<leader>e "<cmd> NvimTreeFocus <CR>"
                  {:desc "nvimtree focus window"}))

(fn after []
  (fn on_attach [bufnr]
    (let [api (autoload :nvim-tree.api)]
      (api.map.on_attach.default bufnr)

      (fn opts [desc]
        {:desc (.. "nvim-tree: " desc) :buffer bufnr})

      (vim.keymap.del :n :y (opts ""))
      (vim.keymap.set :n :y api.fs.copy.node (opts :Copy))
      (vim.keymap.del :n :c (opts ""))
      (vim.keymap.set :n :c api.fs.create (opts "Create File Or Directory"))))

  (let [{: setup} (autoload :nvim-tree)]
    (setup {: on_attach
            :filters {:dotfiles false}
            :disable_netrw true
            :hijack_cursor true
            :sync_root_with_cwd true
            :update_focused_file {:enable true :update_root false}
            :view {:width 30 :preserve_window_proportions true}
            :renderer {:root_folder_label false
                       :highlight_git :all
                       :indent_markers {:enable true}
                       :icons {:glyphs {:default "󰈚"
                                        :git {:unmerged ""}
                                        :folder {:default "󰉋"
                                                 :empty "󰉖"
                                                 :empty_open "󰷏"
                                                 :open "󰝰"
                                                 :symlink "󱉆"}}}}})))

{1 :nvim-tree.lua :cmd [:NvimTreeToggle :NvimTreeFocus] : beforeAll : after}
