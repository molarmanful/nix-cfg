return function(opts)
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

  parser_config.sclin = {
    install_info = {
      url = '~/tree-sitter-sclin',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
  }

  dofile(vim.g.base46_cache .. 'syntax')
  require('nvim-treesitter.configs').setup(opts)
end
