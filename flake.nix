{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-cfg = {
      url = "github:molarmanful/nvim-cfg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      sys =
        modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = modules ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs outputs; };
                # useGlobalPkgs = true;
                useUserPackages = true;
                users.ben = import ./hm;
              };
            }
            {
              system.stateVersion = "24.11";
            }
          ];
        };

    in
    {
      nixosConfigurations = {

        linux = sys [ ./os/linux.nix ];

        wsl = sys [
          nixos-wsl.nixosModules.default
          ./os/wsl.nix
        ];

      };
      homeConfigurations = {

        home = {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./hm
            {
              system.stateVersion = "24.11";
            }
          ];
        };

      };
    };
}
