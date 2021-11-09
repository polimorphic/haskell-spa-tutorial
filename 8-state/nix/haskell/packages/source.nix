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
    owner = "dmjio";
    repo = "miso";
    sha256 = "05vb4yc45g7gmfykwd54cfnv91igmzfh232h46fhh99skfw0388y";
    rev = "9e394bd7700c40af7df8367a91f7a0ff6470ef1a";
  };
  todo = cleanSourceWith {
    src = ../../../.;
    filter = filteredSrc;
  };
}
