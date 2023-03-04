vim.g.mapleader = ' '


vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.asm" },
    callback = function()
        local function align_comments()
            vim.cmd [[%!column -L -t -s ';' -o ' ;']]
            vim.cmd [[%s/\ *;\ *$//g]]
        end
        vim.keymap.set('v', '<leader>cl', "!column -L -t -s ';' -o ' ;'<CR>:%s/\\ *;\\ *$//g <CR>")
        vim.keymap.set('n', '<leader>cl', align_comments)
    end
})

vim.keymap.set('n', '<leader>fj', ':bn<CR>', { silent = true })
vim.keymap.set('n', '<leader>fk', ':bp<CR>', { silent = true })

vim.keymap.set('n', '<M-h>', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<M-j>', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<M-k>', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<M-l>', ':wincmd l<CR>', { silent = true })

vim.keymap.set('n', 'L', '$', { silent = true })
vim.keymap.set('n', 'H', '^', { silent = true })
