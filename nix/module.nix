inputs: { config, wlib, lib, pkgs, ... }:
{
  imports = [
    wlib.wrapperModules.neovim
    ./plugins.nix
  ];

  options = {
    # build plugins from inputs set
    nvim-lib.pluginsFromPrefix = lib.mkOption {
      type = lib.types.raw;
      readOnly = true;
      default =
        prefix: inputs:
        lib.pipe inputs [
          builtins.attrNames
          (builtins.filter (s: lib.hasPrefix prefix s))
          (map (
            input:
            let
              name = lib.removePrefix prefix input;
            in
            {
              inherit name;
              value = config.nvim-lib.mkPlugin name inputs.${input};
            }
          ))
          builtins.listToAttrs
        ];
    };

    nvim-lib.neovimPlugins = lib.mkOption {
      readOnly = true;
      type = lib.types.attrsOf wlib.types.stringable;
      default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
    };

    # Inform our lua of which top level specs are enabled
    settings.cats = lib.mkOption {
      readOnly = true;
      type = lib.types.attrsOf lib.types.bool;
      default = builtins.mapAttrs (_: v: v.enable) config.specs;
    };
  };

  config = {
    specs.lze = [
      config.nvim-lib.neovimPlugins.lze
      {
        data = config.nvim-lib.neovimPlugins.lzextras;
        name = "lzextras";
      }
    ];

    # These are from the tips and tricks section of the neovim wrapper docs!
    # https://birdeehub.github.io/nix-wrapper-modules/neovim.html#tips-and-tricks
    # We could put these in another module and import them here instead!

    # This submodule modifies both levels of your specs
    specMods =
      {
        # When this module is ran in an inner list,
        # this will contain `config` of the parent spec
        parentSpec ? null,
        # and this will contain `options`
        # otherwise they will be `null`
        parentOpts ? null,
        parentName ? null,
        # and then config from this one, as normal
        config,
        # and the other module arguments.
        ...
      }:
      {
        # you could use this to change defaults for the specs
        # config.collateGrammars = lib.mkDefault (parentSpec.collateGrammars or false);
        # config.autoconfig = lib.mkDefault (parentSpec.autoconfig or false);
        # config.runtimeDeps = lib.mkDefault (parentSpec.runtimeDeps or false);
        # config.pluginDeps = lib.mkDefault (parentSpec.pluginDeps or false);
        # or something more interesting like:
        # add an extraPackages field to the specs themselves
        options.extraPackages = lib.mkOption {
          type = lib.types.listOf wlib.types.stringable;
          default = [ ];
          description = "a extraPackages spec field to put packages to suffix to the PATH";
        };
        # You could do this too
        # config.before = lib.mkDefault [ "INIT_MAIN" ];
      };

    extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];
  };
}
