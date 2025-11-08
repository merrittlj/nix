{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    qtile-flake = {
      url = "github:qtile/qtile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixvim, qtile-flake, sops-nix, ... }@inputs:
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

          qtile = qtile-flake.packages.${final.system}.qtile;
        })
      ];

      helpers = import ./helpers.nix { lib = nixpkgs.lib; };

      # Function to make a NixOS system with Home Manager built-in
      mkHost =
        host: hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit host username hostname helpers sops-nix;
          };

          modules = [
            ./nixos/default.nix
            { nixpkgs.overlays = overlays; }

            sops-nix.nixosModules.sops

            # Home Manager integration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = ./home-manager/default.nix;
              home-manager.extraSpecialArgs = {
                inherit host username hostname helpers nixvim;
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        desktop = mkHost "desktop" "pluto"; 
        laptop = mkHost "laptop" "saturn";
      };
    };
}
