with (import ./nix);
with pkgs.lib;
let
  todo = pkgs.haskell.packages.ghc865.todo;
  deps = todo.getBuildInputs.haskellBuildInputs;
  filteredDeps = filter (x: x != todo) deps;
  inputs = pkgs.haskell.packages.ghc865.ghcWithHoogle (p: filteredDeps);
  shell = pkgs.stdenv.mkDerivation {
    name = "shell";
    buildInputs = with pkgs; [ inputs cabal-install ];
  };
in
  shell