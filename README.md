# Neovim Config
This repo houses my **[Neovim]** configuration as well as a **[Nix]** flake for reproducible builds.

The Neovim binary, it's plugins, and it's runtime dependencies (e.g. language servers or tools) are all provided as a single package through **[wrapper-manager]**.

My configs are sourced by **["packaging"](./package.nix)** them and then using **[nix-utils]** to do all the heavy lifting for sourcing the lua files.

<!-- links -->
[wrapper-manager]: https://github.com/viperML/wrapper-manager
[nix-utils]: https://codeberg.org/skettisouls/nix-utils
[Nix]: https://nixos.org
[Neovim]: https://neovim.io
