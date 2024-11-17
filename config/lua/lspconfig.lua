local lspconfig = require('lspconfig')

local function setup_lsps(list)
  for _, name in ipairs(list) do
    lspconfig[name].setup({
      capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
  end
end

setup_lsps({
  "nil_ls",
  "rust_analyzer",
  "html",
  "cssls",
  "gopls",
  "zls",
  "nushell"
})
