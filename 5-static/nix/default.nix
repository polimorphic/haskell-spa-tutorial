with (builtins.fromJSON (builtins.readFile ./nixpkgs.json));
let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256;
  };
  config.allowUnfree = true;
  overlays = [ (import ./overlay.nix) ];
  pkgs = import nixpkgs { inherit config overlays; };
in
  pkgs
