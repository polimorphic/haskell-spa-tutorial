let
  pkgs = import ./nix;
in
  pkgs.haskell.packages.ghc865.todo
