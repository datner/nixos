{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    disko = {
      url = github:nix-community/disko;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    disko,
    home-manager,
    ...
  } @ attrs: let
    packages = {pkgs, ...}: {
      nixpkgs.overlays = [
        (_self: prev: {
          unstable = import nixpkgs-unstable {
            inherit (prev) system;
          };
        })
      ];
    };
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations.hetzner-cloud = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        ./hetzner.nix
        ./linux.nix
        ./tailscale.nix
        # ./rancher.nix
        # ./caprover.nix
      ];
    };
  };
}
