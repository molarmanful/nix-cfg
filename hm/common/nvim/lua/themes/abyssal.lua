local M = {}

M.base_30 = {
  white = '#c2d6d6',
  darker_black = '#060909',
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
  red = '#f85c7f',
  pink = '#fc8da0',
  baby_pink = '#fdb7c0',
  orange = '#f36855',
  sun = '#f89950',
  yellow = '#fac358',
  green = '#3fb563',
  vibrant_green = '#54ef84',
  teal = '#25b29d',
  cyan = '#38ebd0',
  blue = '#7693f8',
  nord_blue = '#98b0fa',
  dark_purple = '#ad7bfa',
  purple = '#c19ffc',
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
  base09 = M.base_30.sun,
  base0A = M.base_30.yellow,
  base0B = M.base_30.vibrant_green,
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
