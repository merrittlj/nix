{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "lucas";

      overlays = [
        (import ./nixos/overlays/scripts.nix)
        (final: prev: {
          unstable = import nixpkgs-unstable {
            system = final.system;
            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };
          };
        })
      ];

      # Function to make a NixOS system with Home Manager built-in
      mkHost = { hostModule, homeModule, hostname }:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit username hostname;
          };

          modules = [
            { nixpkgs.overlays = overlays; }
            hostModule

            # Home Manager integration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import homeModule;
              home-manager.extraSpecialArgs = {
                inherit username nixvim;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost {
          hostModule = ./nixos/desktop/default.nix;
          homeModule = ./home-manager/desktop.nix;
          hostname = "pluto";
        };

        laptop = mkHost {
          hostModule = ./nixos/laptop/default.nix;
          homeModule = ./home-manager/laptop.nix;
          hostname = "saturn";
        };
      };
    };
}
