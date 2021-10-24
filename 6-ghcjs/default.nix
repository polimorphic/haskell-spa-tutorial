let
  pkgs = import ./nix;
in pkgs.buildEnv {
  name = "todo";
  paths =
  [ pkgs.haskell.packages.ghc865.todo
    pkgs.haskell.packages.ghcjs86.todo
    pkgs.todo-js
  ];
}
