{ stdenvNoCC }:

stdenvNoCC.mkDerivation {
  name = "neovim-configs";
  phases = [ "installPhase" ];

  src = builtins.filterSource
    (path: type: baseNameOf path != "default.nix")
    ./config;

  installPhase = ''
    cp -r $src $out
  '';
}
