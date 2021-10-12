{ lib, fetchFromGitHub, fetchgit, fetchzip, ... }:
with lib;
let
  filteredSrc = name: type: let baseName = baseNameOf (toString name); in (
      (type == "regular" && hasSuffix ".hs" baseName) ||
      (hasSuffix ".jpg" baseName) ||
      (hasSuffix ".cabal" baseName) ||
      (hasSuffix ".png" baseName) ||
      (hasSuffix ".svg" baseName) ||
      (hasSuffix ".ttf" baseName) ||
      (hasSuffix ".otf" baseName) ||
      (hasSuffix ".gif" baseName) ||
      (hasSuffix ".css" baseName) ||
      (hasSuffix ".ico" baseName) ||
      (hasSuffix ".js" baseName) ||
      (baseName == "LICENSE") ||
      (type == "directory" && baseName != "dist") ||
      (type == "directory" && baseName != "dist-newstyle") ||
      (type == "directory" && baseName != "dist-ghcjs")
    );
in
{
  miso = fetchFromGitHub {
    owner = "tysonzero";
    repo = "miso";
    sha256 = "0cb8rxm3d3rx65dnin3c16lq924pqm2lcfip18q4kn8x1kkpvyba";
    rev = "d8a9854d26ae7235666e36ec99d5048842bef0ad";
  };
  todo = cleanSourceWith {
    src = ../../../.;
    filter = filteredSrc;
  };
}
