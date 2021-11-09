let
  pkgs = import ./nix;
in pkgs.buildEnv {
  name = "todo";
  paths =
  [ pkgs.haskell.packages.ghc8107.todo
    pkgs.haskell.packages.ghcjs810.todo
    pkgs.todo-js
  ];
}
