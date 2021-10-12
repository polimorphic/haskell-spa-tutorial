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
  todo = cleanSourceWith {
    src = ../../../.;
    filter = filteredSrc;
  };
}
