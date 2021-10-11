pkgs:
let
  source = import ../source.nix pkgs;
in
with pkgs.haskell.lib;
self: super:
{
  todo = disableExecutableProfiling (
    disableLibraryProfiling (self.callCabal2nix "todo" source.todo {})
  );
}
