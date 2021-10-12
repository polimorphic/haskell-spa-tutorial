pkgs:
let
  source = import ../source.nix pkgs;
in
with pkgs.haskell.lib;
self: super:
{
  jsaddle-warp = dontCheck (
    overrideCabal super.jsaddle-warp (drv: { broken = false; })
  );
  miso = self.callHackageDirect {
    pkg = "miso";
    ver = "1.8.0.0";
    sha256 = "18941ifmn31y5v36k7r6127l2mrv956qscsaga79qjwksivyqjvd";
  } {};
  todo = disableExecutableProfiling (
    disableLibraryProfiling (self.callCabal2nix "todo" source.todo {})
  );
}
