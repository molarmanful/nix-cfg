[{1 :vtsls
  :lsp {:filetypes [:javascript
                    :javascriptreact
                    :typescript
                    :typescriptreact
                    :svelte]
        :settings {:complete_function_calls true
                   :vtsls {:enableMoveToFileCodeAction true
                           :autoUseWorkspaceTsdk true
                           :experimental {:maxInlayHintLength 30
                                          :completion {:enableServerSideFuzzyMatch true}}
                           :tsserver {:globalPlugins [{:name :typescript-svelte-plugin
                                                       :location ""
                                                       :enableForWorkspaceTypeScriptVersions true}]}}
                   :typescript {:updateImportsOnFileMove {:enabled :always}
                                :suggest {:completeFunctionCalls true}
                                :inlayHints {:enumMemberValues {:enabled true}
                                             :functionLikeReturnTypes {:enabled true}
                                             :parameterNames {:enabled :literals}
                                             :parameterTypes {:enabled true}
                                             :propertyDeclarationTypes {:enabled true}
                                             :variableTypes {:enabled false}}}}}}]
