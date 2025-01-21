local lspconfig = require('lspconfig')

lspconfig.nixd.setup({
  cmd = { "nixd", "--inlay-hints=true", "--semantic-tokens=true" },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },

      options = {
        regolith = {
          expr = '(builtins.getFlake "github:skettisouls/nixos").nixosConfigurations.argon.options',
        },
      },
    },
  },
})
