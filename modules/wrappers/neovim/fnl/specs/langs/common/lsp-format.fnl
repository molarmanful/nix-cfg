(local {: autoload} (require :nfnl.module))
(local {: ->set} (autoload :nfnl.core))

(local supported (->set [:null-ls
                         :dprint
                         :ruff
                         :taplo
                         :biome
                         :rust-analyzer
                         :metals]))

(fn after []
  (let [{: setup : on_attach} (autoload :lsp-format)
        config (collect [_ v (pairs (vim.fn.getcompletion "" :filetype))]
                 v
                 {:sync true})]
    (setup config)

    (fn callback [{:data {: client_id} : buf}]
      (let [client (assert (vim.lsp.get_client_by_id client_id))]
        (case client.name
          :eslint (vim.api.nvim_create_autocmd :BufWritePre
                                               {:buffer buf
                                                :command :LspEslintFixAll})
          (where name (. supported name)) (on_attach client buf)))
      nil)

    (vim.api.nvim_create_autocmd :LspAttach {: callback})))

{1 :lsp-format.nvim :event [:BufReadPost :BufNewFile] : after}
