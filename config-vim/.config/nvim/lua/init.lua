local nvim_lsp = require('lspconfig')
local vim = vim

-- LSP
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'completion'.on_attach()

    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

local servers = {
    'bashls',
    'rls',
    'tsserver',
    'vimls',
    'texlab',
    -- 'pyls'
    'anakin_language_server',
    -- 'jedi_language_server'
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
    }
end

nvim_lsp.sumneko_lua.setup {
    cmd = {'/usr/bin/lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
    on_attach = on_attach
}


-- Tree Sitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "python",     -- one of "all", "language", or a list of languages
    highlight = {
        enable = false,              -- false will disable the whole extension
        disable = { "c", "rust" },  -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "+",
            scope_incremental = "grc",
            node_decremental = "-",
        },
    },
    indent = {
        enable = true
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gd",
                goto_definition_lsp_fallback = "gD",
            },
        },
    },
}

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    signs = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
        spacing = 4,
        prefix = '▶ ',
    },
    -- Disable a feature
    update_in_insert = false,
}
)

-- Colorizer
require 'colorizer'.setup (
    { '*'; '!vim-plug'; 'lua'; },
    {
        rgb_fn   = true;
        RRGGBBAA = true;
        hsl_fn   = true;
    }
)

-- vim: fdm=indent
