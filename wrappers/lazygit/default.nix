{ pkgs, ... }:
{
  wrappers.lazygit = {
    basePackage = pkgs.lazygit;

    flags = [ "--use-config-file" ./config.yml ];
  };
}
