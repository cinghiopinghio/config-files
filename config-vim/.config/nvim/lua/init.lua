local lspconfig = require('lspconfig')
local vim = vim

-- LSP
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-d>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- goto definition is defined by treesitter
end

local servers = {
    'bashls',
    'rls',
    -- 'tsserver',
    'vimls',
    'texlab',
    -- 'pyls'
    'anakin_language_server',
    -- 'jedi_language_server'
    'tsserver',
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
    }
end

lspconfig.sumneko_lua.setup {
    cmd = {'/usr/bin/lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            }
        }
    }
}

lspconfig.jsonls.setup {
    cmd = {'json-languageserver', '--stdio'},
    on_attach = on_attach,
}
-- lspconfig.efm.setup {
--     cmd = {"efm-langserver", "-logfile", "/home/mauro/efm.log"},
--     on_attach = on_attach,
--     filetypes = {'python'},
--     root_dir = lspconfig.util.root_pattern(".git/", ".bashrc"),
--     settings = {
--         rootMarkers = {".git/", ".bashrc"},
--         languages = {
--             python = {
--                 -- {
--                 --     lintCommand = "flake8 --max-line-lenght 100 --stdin-display-name ${INPUT} -",
--                 --     lintIgnoreExitCode = true,
--                 --     lintStdin = true,
--                 --     lintFormats = { "%f:%l:%c: %m" },
--                 --     onSave = true,
--                 -- },
--                 {
--                     lintCommand = "pylint -j 1 --from-stdin ${INPUT} --score no --msg-template '{path}:{line}:{column}:{C} {msg_id} {msg} ({symbol}) -- PL' | sed -e 's/:I\\s/:H /' -e 's/:[CR]\\s/:I /' -e '/C0103/d'",
--                     lintIgnoreExitCode = true,
--                     lintStdin = true,
--                     lintDebounce = 5,
--                     lintFormats = {"%f:%l:%c:%t %m"},
--                     onSave = true,
--                 },
--             },
--         },
--     },
--     diagnostics = {
--         onChange = false
--     }
-- }

-- Bubbly
vim.g.bubbly_statusline = {
    'mode',
    'path',
    'truncate',
    'branch',
    'divisor',
    'builtinlsp.diagnostic_count',
    'builtinlsp.current_function',
    'filetype',
    'progress',
}
vim.g.bubbly_colors = {
    mode = {
        normal = {
            foreground = 'black',
            background = 'green',
        },
    },
    filetype = {
        foreground = 'black',
        background = 'green',
    },
    path = {
        path         = {
            background = 'white',
            foreground = 'black'
        },
        unmodifiable = {
            background = 'lightgrey',
            foreground = 'foreground'
        },
        readonly     = {
            background = 'grey',
            foreground = 'foreground'
        },
        modified     = {
            background = 'grey',
            foreground = 'yellow'
        },
    },
    tabline = {
        active = {
            foreground = 'black',
            background = 'purple'
        },
        inactive = 'lightgrey'
    },
    progress = {
        rowandcol = { background = 'lightgrey', foreground = 'darkgrey' },
        percentage = { background = 'grey', foreground = 'foreground' },
    },
}
vim.g.bubbly_palette = {
    background = "Statusline background",
    foreground = "Statusline foreground",
    red        = "Error foreground",
    green      = vim.g.terminal_color_2,
    yellow     = vim.g.terminal_color_3,
    blue       = vim.g.terminal_color_4,
    purple     = vim.g.terminal_color_5,
    cyan       = vim.g.terminal_color_6,
    black      = "VertSplit foreground",
    darkgrey   = "LineNr background",
    grey       = "Visual background",
    lightgrey  = "FoldColumn foreground",
    white      = "Cursor foreground",
}
vim.g.bubbly_tags = {
    mode = {
        normal = 'N',
        insert = 'I',
        visual = 'V',
        visualblock = 'VB',
        command = 'C',
        terminal = 'T',
        replace = 'R',
        default = 'U',
    },
    paste = 'P',
    filetype = {
        noft = 'no ft',
    },
}
vim.g.bubbly_symbols = {
    path = {
        readonly = 'RO',
        unmodifiable = '⛔',
        modified = '➕',
    },
}
vim.g.bubbly_width = {
    progress = {
        rowandcol = 0,
    }
}


-- Tree Sitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "python",     -- one of "all", "language", or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
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
        enable = false
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "gd",
            },
        },
    },
    playground = {
        enable = true,
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
    {'*'; '!vim-plug'},
    {
        rgb_fn   = true;
        RRGGBBAA = true;
        hsl_fn   = true;
    }
)

-- vim: fdm=indent
