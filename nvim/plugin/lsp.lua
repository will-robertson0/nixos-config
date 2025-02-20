-- from github.com/vimjoyer/nvim-video

local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- the below language server names (such as lua_ls for lua-language-server) can be found at:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
}

require('lspconfig').rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "rust-analyzer" }, -- dunno if this was needed
}

require('lspconfig').pyright.setup {
    on_attach = on_attach,
	capabilities = capabilities,
}

require('lspconfig').clangd.setup {
    on_attach = on_attach,
	capabilities = capabilities,
}

require('lspconfig').gopls.setup {
    on_attach = on_attach,
	capabilities = capabilities,
}

require('lspconfig').ts_ls.setup {
    on_attach = on_attach,
	capabilities = capabilities,
}

require('lspconfig').superhtml.setup {
    on_attach = on_attach,
	capabilities = capabilities,
}
