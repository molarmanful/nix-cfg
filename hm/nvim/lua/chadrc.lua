local M = {}

local gen_base = function(m)
  m.statusline_bg = m.black2
  m.lightbg = m.one_bg2
  return {
    base_16 = {
      base00 = m.black,
      base01 = m.one_bg,
      base02 = m.one_bg2,
    },
    base_30 = m,
  }
end

local theme = 'nightfox'

M.base46 = {
  theme = theme,
  changed_themes = {
    [theme] = gen_base {
      black = '#000000',
      darker_black = '#07080d',
      black2 = '#0e101a',
      one_bg = '#151826',
      one_bg2 = '#1c2033',
      one_bg3 = '#232840',
    },
  },
}

M.ui = {
  statusline = {
    theme = 'minimal',
  },
}

return M
