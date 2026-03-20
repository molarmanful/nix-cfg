(local {: autoload} (require :nfnl.module))

(fn after []
  (let [{: setup : load_extension} (autoload :telescope)
        actions (autoload :telescope.actions)]
    (fn cfg []
      (setup {:defaults {:prompt_prefix "   "
                         :selection_caret " "
                         :entry_prefix " "
                         :sorting_strategy :ascending
                         :layout_config {:width 0.87
                                         :height 0.8
                                         :horizontal {:prompt_position :top
                                                      :preview_width 0.55}}
                         :mappings {:n {:q actions.close}
                                    :i {:<C-j> :move_selection_next
                                        :<C-k> :move_selection_previous}}}}))

    (fn exts []
      (let [xs [:themes :terms :persisted :fzf :ui-select :file_browser]]
        (each [_ x (ipairs xs)]
          (load_extension x))))

    (fn keys []
      (vim.keymap.set :n :<leader>fw "<cmd> Telescope live_grep <CR>"
                      {:desc "telescope live grep"})
      (vim.keymap.set :n :<leader>fb "<cmd> Telescope buffers <CR>"
                      {:desc "telescope find buffers"})
      (vim.keymap.set :n :<leader>fh "<cmd> Telescope help_tags <CR>"
                      {:desc "telescope help page"})
      (vim.keymap.set :n :<leader>ma "<cmd> Telescope marks <CR>"
                      {:desc "telescope find marks"})
      (vim.keymap.set :n :<leader>fo "<cmd> Telescope oldfiles <CR>"
                      {:desc "telescope find oldfiles"})
      (vim.keymap.set :n :<leader>fz
                      "<cmd> Telescope current_buffer_fuzzy_find <CR>"
                      {:desc "telescope find in current buffer"})
      (vim.keymap.set :n :<leader>pt "<cmd> Telescope terms <CR>"
                      {:desc "telescope pick hidden term"})
      (vim.keymap.set :n :<leader>ff
                      "<cmd> Telescope file_browser hidden=true <CR>"
                      {:desc "telescope file browser"})
      (vim.keymap.set :n :<leader>fr
                      "<cmd> Telescope file_browser hidden=true path=%:p:h <CR>"
                      {:desc "telescope file browser (relative)"})
      (vim.keymap.set :n :<leader>fa
                      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>"
                      {:desc "telescope find all files"})
      (vim.keymap.set :n :<leader>fs "<cmd> Telescope persisted <CR>"
                      {:desc "telescope find session"})
      (vim.keymap.set :n :<leader>fx
                      "<cmd> Telescope lsp_document_symbols <CR>"
                      {:desc "telescope find LSP symbol"})
      (vim.keymap.set :n :<leader>fX
                      "<cmd> Telescope lsp_workspace_symbols <CR>"
                      {:desc "telescope find LSP symbol"})
      (vim.keymap.set :n :<leader>q "<cmd> Telescope diagnostics bufnr=0 <CR>"
                      {:desc "telescope show buffer LSP diagnostics"})
      (vim.keymap.set :n :<leader>Q "<cmd> Telescope diagnostics <CR>"
                      {:desc "telescope show project LSP diagnostics"}))

    (cfg)
    (exts)
    (keys)))

[{1 :telescope.nvim :event :DeferredUIEnter : after}
 {1 :telescope-fzf-native.nvim :on_plugin [:telescope.nvim]}
 {1 :telescope-ui-select.nvim :on_plugin [:telescope.nvim]}
 {1 :telescope-file-browser.nvim :on_plugin [:telescope.nvim]}]
