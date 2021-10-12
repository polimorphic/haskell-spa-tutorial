let
  pkgs = import ./nix;
in pkgs.buildEnv {
  name = "poli-release";
  paths =
  [ pkgs.haskell.packages.ghc865.todo
    pkgs.haskell.packages.ghcjs86.todo
    pkgs.todo-js
  ];
}
