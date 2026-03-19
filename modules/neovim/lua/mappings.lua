local set = vim.keymap.set

-- GENERAL

set('n', '<Esc>', '<cmd>noh<CR>', { desc = 'general clear highlights' })
set('n', '<BS>', "<cmd> let @/ = '' <CR>", { desc = 'general clear /' })
set('i', 'jk', '<ESC>', { desc = 'general escape insert mode', nowait = true })
set('i', 'kj', '<ESC>', { desc = 'general escape insert mode', nowait = true })
set('v', '>', '>gv', { desc = 'general indent' })
set('v', '<', '<gv', { desc = 'general dedent' })
set('n', '<C-s>', '<cmd>w<CR>', { desc = 'general save file' })

-- SWITCH

set('n', '<C-h>', '<C-w>h', { desc = 'switch window left' })
set('n', '<C-j>', '<C-w>j', { desc = 'switch window down' })
set('n', '<C-k>', '<C-w>k', { desc = 'switch window up' })
set('n', '<C-l>', '<C-w>l', { desc = 'switch window right' })

-- TOGGLE

set('n', '<leader>n', '<cmd> set nu! <CR>', { desc = 'toggle line number' })
set('n', '<leader>rn', '<cmd> set rnu! <CR>', { desc = 'toggle relative number' })
set('n', '<leader>ch', '<cmd> NvCheatsheet <CR>', { desc = 'toggle nvcheatsheet' })
set('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
set('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

-- NEOGIT

set('n', '<leader>go', '<cmd> Neogit <CR>', { desc = 'neogit open neogit' })

-- NVIMTREE

set('n', '<C-n>', '<cmd> NvimTreeToggle <CR>', { desc = 'nvimtree toggle window' })
set('n', '<leader>e', '<cmd> NvimTreeFocus <CR>', { desc = 'nvimtree focus window' })
