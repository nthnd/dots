require("neotest").setup({
  adapters = {
    require("neotest-rust"),
  },
})
vim.keymap.set('n', '<leader>tt', require('neotest').run.run)
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand("%")) end)
vim.keymap.set('n', '<leader>to', require('neotest').output.open)
vim.keymap.set('n', '<leader>tp', require('neotest').output_panel.toggle)
