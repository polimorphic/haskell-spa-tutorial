pkgs:
let
  source = import ../source.nix pkgs;
in
with pkgs.haskell.lib;
self: super:
{
  jsaddle = addBuildDepend super.jsaddle self.ghcjs-base;
  miso = self.callCabal2nix "miso" source.miso {};
  mkDerivation = args:
    super.mkDerivation (args // { doCheck = false; enableLibraryProfiling = false; });
  todo = dontHaddock (disableExecutableProfiling (
    disableLibraryProfiling (self.callCabal2nix "todo" source.todo {})
  ));
}
