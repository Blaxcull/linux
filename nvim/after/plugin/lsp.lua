-- Reserve a space in the gutter for diagnostics and other signs
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.signcolumn = 'yes'
vim.keymap.set("n", "<leader>ce", function()
  local diag = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })[1]
  if diag then
    vim.fn.setreg("+", diag.message)
    print("Copied diagnostic to clipboard!")
  else
    print("No diagnostic on this line.")
  end
end)


-- Add `cmp_nvim_lsp` capabilities to the LSP config
-- This should be executed before configuring any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Setup LSP actions on `LspAttach` event
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
  end,
})


local lspconfig = require('lspconfig')



lspconfig.ts_ls.setup({})

-- ESLint
lspconfig.eslint.setup({})
lspconfig.clangd.setup({})



lspconfig.gopls.setup({})

-- Rust
lspconfig.rust_analyzer.setup({})

-- Python
lspconfig.pyright.setup({})

-- C/C++
lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index" }, -- Use clangd as the LSP server
  filetypes = { "c", "cpp", "objc", "objcpp" }, -- File types handled by clangd
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git") -- Project root detection
})


-- Setup completion with nvim-cmp
local cmp = require('cmp')

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})




cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<A-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<A-Space>'] = cmp.mapping.complete(),
    ['<A-n>']= cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<A-Tab>'] = cmp.mapping.confirm({ select = true }),

  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  snippet = {
    expand = function(args)
      -- Ensure you're using a snippet engine like LuaSnip
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

