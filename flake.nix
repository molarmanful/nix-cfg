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
      flake-utils,
      home-manager,
      ...
    }@inputs:
    let

      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      sys =
        modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
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
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./hm
            {
              system.stateVersion = "24.11";
            }
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nil
          nixfmt-rfc-style
          statix
          deadnix
        ];
      };

    };
}
