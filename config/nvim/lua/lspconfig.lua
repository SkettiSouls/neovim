local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup ({
	capabilities = capabilities,
})

lspconfig.nil_ls.setup ({
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup ({
	capabilities = capabilities,
})

lspconfig.html.setup ({
	capabilities = capabilities,
})

lspconfig.cssls.setup ({
	capabilities = capabilities,
})
