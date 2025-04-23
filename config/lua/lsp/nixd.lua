vim.lsp.config['nixd'] = {
  cmd = { "nixd", "--inlay-hints=true", "--semantic-tokens=true" },
  root_markers = { "flake.nix" },
  filetypes = { "nix" },

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
}
