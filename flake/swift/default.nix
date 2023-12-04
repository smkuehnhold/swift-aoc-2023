{ callPackage, ... }:

let
  image = callPackage ./image { };
in {
  inherit image;
  shell = callPackage ./shell { swiftImage = image; };
}