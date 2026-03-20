(fn on_attach [_ bufnr]
  (fn opts [desc]
    {:buffer bufnr :desc (.. "LSP " desc)})

  (vim.keymap.set :n :<leader>wa vim.lsp.buf.add_workspace_folder
                  (opts "add workspace folder"))
  (vim.keymap.set :n :<leader>wr vim.lsp.buf.remove_workspace_folder
                  (opts "remove workspace folder"))
  (vim.keymap.set :n :<leader>wl
                  #(print (vim.inspect (vim.lsp.buf.list_workspace_folders)))
                  (opts "list workspace folders"))
  (vim.keymap.set :n :<leader>ra (require :nvchad.lsp.renamer)
                  (opts :NvRenamer))
  (vim.keymap.set :n :<leader>lf vim.diagnostic.open_float
                  (opts "lspconfig floating diagnostic"))
  (vim.keymap.set :n "[d" #(vim.diagnostic.jump {:count -1 :float {}})
                  (opts "lspconfig goto prev"))
  (vim.keymap.set :n "]d" #(vim.diagnostic.jump {:count 1 :float {}})
                  (opts "lspconfig goto next"))
  (vim.keymap.set :n :gd "<cmd> Telescope lsp_definitions <CR>"
                  (opts "telescope find LSP definitions"))
  (vim.keymap.set :n :gD "<cmd> Telescope lsp_type_definitions <CR>"
                  (opts "telescope find LSP definitions"))
  (vim.keymap.set :n :grr "<cmd> Telescope lsp_references <CR>"
                  (opts "telescope find LSP references")))

(fn on_init [client _]
  (when (client:supports_method :textDocument/semanticTokens)
    (set client.server_capabilities.semanticTokensProvider nil)))

(fn before []
  (let [capabilities (vim.lsp.protocol.make_client_capabilities)]
    (set capabilities.textDocument.completion.completionItem
         {:documentationFormat [:markdown :plaintext]
          :snippetSupport true
          :preselectSupport true
          :insertReplaceSupport true
          :labelDetailsSupport true
          :deprecatedSupport true
          :commitCharactersSupport true
          :tagSupport {:valueSet [1]}
          :resolveSupport {:properties [:documentation
                                        :command
                                        :detail
                                        :additionalTextEdits]}})
    (vim.lsp.config "*" {: on_attach : on_init : capabilities})))

{1 :nvim-lspconfig
 :event [:BufReadPost :BufNewFile]
 :lsp (fn [{: name : lsp}]
        (vim.lsp.config name (or lsp {}))
        (vim.lsp.enable name))
 : before}
