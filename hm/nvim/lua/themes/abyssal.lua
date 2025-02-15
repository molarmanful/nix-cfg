local M = {}

M.base_30 = {
  white = '#c2d6d6',
  darker_black = '#000000',
  black = '#000000',
  black2 = '#0c1212',
  one_bg = '#141f1f',
  one_bg2 = '#1f3030',
  one_bg3 = '#294040',
  grey = '#527a7a',
  grey_fg = '#5e8c8c',
  grey_fg2 = '#588383',
  light_grey = '#5f8d8d',
  line = '#1f2e2e',
  red = '#ed6883',
  pink = '#f692a2',
  baby_pink = '#f9b9c1',
  orange = '#ef702e',
  sun = '#f89a45',
  yellow = '#fcc06c',
  green = '#3bb561',
  vibrant_green = '#4ff082',
  teal = '#00b39d',
  cyan = '#00edd0',
  blue = '#329eff',
  nord_blue = '#74b9ff',
  dark_purple = '#ab80ef',
  purple = '#d4c2f9',
}

M.base_30.statusline_bg = M.base_30.black2
M.base_30.lightbg = M.base_30.one_bg2
M.base_30.pmenu_bg = M.base_30.blue
M.base_30.folder_bg = M.base_30.blue

M.base_16 = {
  base00 = M.base_30.black,
  base01 = M.base_30.one_bg,
  base02 = M.base_30.one_bg2,
  base03 = M.base_30.one_bg3,
  base04 = M.base_30.grey,
  base05 = M.base_30.white,
  base06 = '#c6d8d8',
  base07 = '#c9dada',
  base08 = M.base_30.red,
  base09 = M.base_30.orange,
  base0A = M.base_30.yellow,
  base0B = M.base_30.green,
  base0C = M.base_30.cyan,
  base0D = M.base_30.nord_blue,
  base0E = M.base_30.dark_purple,
  base0F = M.base_30.purple,
}

M.polish_hl = {
  treesitter = {
    ['@variable.member.key'] = { fg = M.base_16.base05 },
    ['@operator'] = { fg = M.base_30.dark_purple },
    ['@keyword'] = { fg = M.base_30.teal },
    ['@variable.parameter'] = { fg = M.base_30.teal },
  },
}

M.type = 'dark'

M = require('base46').override_theme(M, 'abyssal')

return M
