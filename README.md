# Neovim Config
This repo houses my **[Neovim][1]** configuration, as well as a **[nix][2]** flake for reproducible builds. \
Packages are built using **[flake-parts][3]** and **[nix-wrapper-modules][4]**.

The **[nix][2]** flake exposes two packages:
- **neovim:** [Neovim][1] wrapped with dependencies, plugins, AND my full lua configuration. This is probably the package you want.
- **neovim-impure:** Same as `neovim`, but config is sourced from `~/.config/nvim` instead of being included. Used for hot reloading config changes.

<!-- links -->
[1]: https://neovim.io
[2]: https://nixos.org
[3]: https://flake.parts
[4]: https://github.com/BirdeeHub/nix-wrapper-modules
