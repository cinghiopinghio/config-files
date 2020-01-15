if vim.lsp then
  -- In case I'm reloading.
  vim.lsp.stop_all_clients()

  -- Mappings and settings
  local function lsp_setup(_)
    local function focusable_popup()
      local popup_win
      return function(winnr)
        if popup_win and nvim.win_is_valid(popup_win) then
          if nvim.get_current_win() == popup_win then
            nvim.ex.wincmd "p"
          else
            nvim.set_current_win(popup_win)
          end
          return
        end
        popup_win = winnr
      end
    end

    local diagnostic_popup = focusable_popup()
    local mappings = {
      ["nK"]    = map_cmd [[call lsp#text_document_hover()]];
      ["ngd"]   = map_cmd [[call lsp#text_document_definition()]];
      ["ngD"]   = { function()
        local _, winnr = vim.lsp.util.show_line_diagnostics()
        diagnostic_popup(winnr)
      end };
      ["ngp"]   = { function()
        local params = vim.lsp.protocol.make_text_document_position_params()
        local callback = vim.lsp.builtin_callbacks["textDocument/peekDefinition"]
        vim.lsp.buf_request(0, 'textDocument/definition', params, callback)
      end };
    }
    nvim.bo.omnifunc = "lsp#omnifunc"
    nvim_apply_mappings(mappings, { buffer = true; silent = true; })
  end

  local nvim_lsp = require'nvim_lsp'
  local servers = {'texlab', 'gopls', 'clangd', 'elmls', 'tsserver', 'bashls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = lsp_setup;
    }
  end
end
