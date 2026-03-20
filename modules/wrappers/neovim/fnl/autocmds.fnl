(vim.api.nvim_create_autocmd :FileType
                             {:pattern "*"
                              :callback (fn [] (pcall vim.treesitter.start) nil)})
