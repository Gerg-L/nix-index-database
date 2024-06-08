{
  description = "nix-index database";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;

      testSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      systems = testSystems ++ [
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      mkPackages =
        pkgs:
        let
          nix-index-database =
            let
              generated = import ./generated.nix;
            in
            pkgs.fetchurl {
              url = generated.url + pkgs.stdenv.system;
              hash = generated.hashes.${pkgs.stdenv.system};
              passthru.unsafeDiscardReferences.out = true;
            };
        in
        {
          inherit nix-index-database;

          nix-index-with-db = pkgs.callPackage ./nix-index-wrapper.nix { inherit nix-index-database; };
          comma-with-db = pkgs.callPackage ./comma-wrapper.nix { inherit nix-index-database; };
        };
    in
    {
      packages = lib.genAttrs systems (
        system:
        {
          default = self.packages.${system}.nix-index-with-db;
        }
        // mkPackages nixpkgs.legacyPackages.${system}
      );

      overlays.nix-index = final: prev: mkPackages final;

      darwinModules.nix-index = import ./darwin-module.nix self;

      hmModules.nix-index = import ./home-manager-module.nix self;

      nixosModules.nix-index = import ./nixos-module.nix self;

      checks = lib.genAttrs testSystems (
        system:
        import ./tests.nix {
          inherit system nixpkgs;
          nixIndexModule = self.nixosModules.nix-index;
        }
      );

      formatter = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
