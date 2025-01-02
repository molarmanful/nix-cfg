{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: 
    let
      inherit (self) outputs;
    in {
      nixosConfigurations = {

        jimbo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-wsl.nixosModules.default
            ./os
            home-manager.nixosModules.home-manager
            {
              system.stateVersion = "24.05";
            }
          ];
        };

        jimbo-wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-wsl.nixosModules.default
            ./os/wsl
            home-manager.nixosModules.home-manager
            {
              system.stateVersion = "24.05";
            }
          ];
        };

      };
    };
}
