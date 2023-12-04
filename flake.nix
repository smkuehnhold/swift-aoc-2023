{
  description = "A very basic, docker-based, swift development environment";

  inputs = {
    nixpkgs.url = "github:/NixOS/nixpkgs/nixos-23.11-small";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
      swift = pkgs.callPackage ./flake/swift {};
    in {
      packages."${system}" = {
        swift-image = swift.image;
      };

      devShells."${system}".default = swift.shell;
    };
}
