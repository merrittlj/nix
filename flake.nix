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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    code-insiders = {
      url = "github:iosmanthus/code-insiders-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixvim, sops-nix, code-insiders, ... }@inputs:
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
        code-insiders.overlays.default
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
                inherit host username hostname helpers nixvim sops-nix;
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        desktop = mkHost "desktop" "pluto"; 
        macbook = mkHost "macbook" "saturn";
        thinkpad = mkHost "thinkpad" "thunk";
      };
    };
}
