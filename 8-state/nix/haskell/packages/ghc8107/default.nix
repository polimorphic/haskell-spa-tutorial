pkgs:
let
  source = import ../source.nix pkgs;
in
with pkgs.haskell.lib;
self: super:
{
  miso = self.callCabal2nix "miso" source.miso {};
  todo = disableExecutableProfiling (
    disableLibraryProfiling (self.callCabal2nix "todo" source.todo {})
  );
}
