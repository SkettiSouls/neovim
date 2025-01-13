{ stdenv }:

stdenv.mkDerivation {
  name = "neovim-configs";
  phases = [ "installPhase" ];

  src = builtins.filterSource
    (path: type: baseNameOf path != "default.nix")
    ./.;

  installPhase = ''
    cp -r $src $out
  '';
}
