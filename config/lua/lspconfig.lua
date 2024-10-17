local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp_setup = { capabilities = capabilities, }

lspconfig.nil_ls.setup(cmp_setup)
lspconfig.rust_analyzer.setup(cmp_setup)
lspconfig.html.setup(cmp_setup)
lspconfig.cssls.setup(cmp_setup)
lspconfig.gopls.setup(cmp_setup)
