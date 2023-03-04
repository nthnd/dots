local servers = { 'tsserver', 'clojure_lsp', 'pyright', 'emmet_ls', 'intelephense', 'lua_ls', 'cssls' }

--
--         .--------.---.-.-----.-----.-----.
--         |        |  _  |__ --|  _  |     |
--         |__|__|__|___._|_____|_____|__|__|
--
--

require('mason').setup()
require('mason-lspconfig').setup({
})

--
--      __                                       ___ __
--     |  |.-----.-----.______.----.-----.-----.'  _|__|.-----.
--     |  ||__ --|  _  |______|  __|  _  |     |   _|  ||  _  |
--     |__||_____|   __|      |____|_____|__|__|__| |__||___  |
--               |__|                                   |_____|
--

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, opts)

local on_attach = function(_, bufnr)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('n', '<leader>tr', '<cmd>Telescope lsp_references<cr>', bufopts)
    vim.keymap.set('n', '<leader>td', '<cmd>Telescope diagnostics<cr>', bufopts)
end


local lsp_flags = {
    debounce_text_changes = 150,
}


for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
    }
end

require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
}



--                   __
--     .-----.--.--.|__|.--------.______.----.--------.-----.
--     |     |  |  ||  ||        |______|  __|        |  _  |
--     |__|__|\___/ |__||__|__|__|      |____|__|__|__|   __|
--                                                    |__|


vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Set up nvim-cmp.
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

--     _______ ___ ___ _______ ______ _______
--    |    ___|   |   |_     _|   __ \   _   |
--    |    ___|-     -| |   | |      <       |
--    |_______|___|___| |___| |___|__|___|___|
--

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

local signs = {
    Error = "",
    Warn  = "",
    Hint  = "",
    Info  = "",
}

-- local signs = {
--     Error = "",
--     Warn  = "",
--     Hint  = "",
--     Info  = "",
-- }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
