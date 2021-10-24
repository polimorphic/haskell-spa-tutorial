let
  pkgs = import ./nix;
in
  pkgs.haskell.packages.ghc8107.todo
