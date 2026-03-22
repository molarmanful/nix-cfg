(vim.keymap.set :n :<Esc> "<cmd> noh <CR>" {:desc "general hide highlights"})
(vim.keymap.set :n :<BS> "<cmd> let @/ = '' <CR>" {:desc "general clear /"})
(vim.keymap.set :i :jk :<ESC> {:desc "general escape insert mode" :nowait true})
(vim.keymap.set :i :kj :<ESC> {:desc "general escape insert mode" :nowait true})
(vim.keymap.set :v ">" :>gv {:desc "general indent"})
(vim.keymap.set :v "<" :<gv {:desc "general dedent"})
(vim.keymap.set :n :<C-s> "<cmd> w <CR>" {:desc "general save file"})

(vim.keymap.set :n :<C-h> :<C-w>h {:desc "switch window left"})
(vim.keymap.set :n :<C-j> :<C-w>j {:desc "switch window down"})
(vim.keymap.set :n :<C-k> :<C-w>k {:desc "switch window up"})
(vim.keymap.set :n :<C-l> :<C-w>l {:desc "switch window right"})

(vim.keymap.set :n :<leader>n "<cmd> set nu! <CR>" {:desc "toggle line number"})
(vim.keymap.set :n :<leader>rn "<cmd> set rnu! <CR>"
                {:desc "toggle relative number"})

(vim.keymap.set :n :<leader>/ :gcc {:desc "toggle comment" :remap true})
(vim.keymap.set :v :<leader>/ :gc {:desc "toggle comment" :remap true})
