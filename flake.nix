{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    with inputs;
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);

      luaInputs = [
        "global.lua"
        "auto-pairs.lua"
        "bar.lua"
        "cmp.lua"
        "comment.lua"
        "file-manager.lua"
        "guess-indent.lua"
        "images.lua"
        "keys.lua"
        "lspconfig.lua"
        "markdown.lua"
        "rules.lua"
        "suda.lua"
        "telescope.lua"
        "term.lua"
        "treesitter.lua"
      ];

      vimInputs = [ ];
    in
    {
      packages = eachSystem (system:
        let
          inherit (pkgs)
            callPackage
            neovim-unwrapped
            wrapNeovim
            writeShellApplication
            ;

          inherit (pkgs.lib)
            concatStringsSep
            ;

          pkgs = import nixpkgs {
            inherit system;
          };

          neovimConfigs = callPackage ./config { };
          neovimPlugins = callPackage ./plugins.nix { };
          neovimRuntime = callPackage ./runtime.nix { };

          resolvePaths = root: paths: map (relpath: "${root}/${relpath}") paths;

          sourcedLuaConfigs = map (path: "luafile ${path}") (resolvePaths "${neovimConfigs}/lua" luaInputs);
          sourcedVimConfigs = map (path: "source ${path}") (resolvePaths "${neovimConfigs}/vimscript" vimInputs);
          sourcedConfigs = sourcedVimConfigs ++ sourcedLuaConfigs;
          sourceString = concatStringsSep "\n" sourcedConfigs;

          neovimWrapped = wrapNeovim neovim-unwrapped {
            configure = {
              customRC = sourceString;
              packages.all.start = neovimPlugins;
            };
          };
        in
        {
        default = writeShellApplication {
          name = "nvim";
          runtimeInputs = neovimRuntime;
          text = ''
            ${neovimWrapped}/bin/nvim "$@"
          '';
        };
      });
    };
}
