vim.cmd[[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]]
vim.cmd[[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]]

require('plugins')
require('options')
require('keymaps')
require('ide')
require('colors')
require('pl.telescope')
require('pl.tpmd')
require('pl.vslime')
require('pl.neotest')
