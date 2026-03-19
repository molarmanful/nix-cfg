vim.loader.enable()

do
  _G.nixInfo = require(vim.g.nix_info_plugin_name)
  nixInfo.isNix = vim.g.nix_info_plugin_name ~= nil
  ---@module 'lzextras'
  ---@type lzextras | lze
  nixInfo.lze = setmetatable(require 'lze', getmetatable(require 'lzextras'))
  function nixInfo.get_nix_plugin_path(name)
    return nixInfo(nil, 'plugins', 'lazy', name) or nixInfo(nil, 'plugins', 'start', name)
  end
end

nixInfo.lze.register_handlers {
  nixInfo.lze.lsp,
}

nixInfo.lze.h.lsp.set_ft_fallback(function(name)
  local lspcfg = nixInfo.get_nix_plugin_path 'nvim-lspconfig'
  if lspcfg then
    local ok, cfg = pcall(dofile, lspcfg .. '/lsp/' .. name .. '.lua')
    return (ok and cfg or {}).filetypes or {}
  end
  return (vim.lsp.config[name] or {}).filetypes or {}
end)

vim.g.base46_cache = nixInfo.get_nix_plugin_path 'base46' .. '/cache/'

require 'options'

nixInfo.lze.load 'specs'

vim.schedule(function()
  require 'mappings'
end)
