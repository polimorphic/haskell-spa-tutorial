with (import ./nix);
with pkgs.lib;
let
  todo = pkgs.haskell.packages.ghcjs810.todo;
  deps = todo.getBuildInputs.haskellBuildInputs;
  filteredDeps = filter (x: x != todo) deps;
  inputs = pkgs.haskell.packages.ghcjs810.ghcWithPackages (p: filteredDeps);
  shell = pkgs.stdenv.mkDerivation {
    name = "shell";
    buildInputs = with pkgs; [ inputs cabal-install ];
  };
in
  shell
