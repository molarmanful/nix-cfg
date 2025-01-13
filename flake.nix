{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    kirsch.url = "github:molarmanful/kirsch";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      kirsch,
      ...
    }@inputs:
    let

      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      sargs = {
        inherit inputs outputs;
        inherit (kirsch.packages.${system}) kirsch;
      };

      sys =
        { modules, hm }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = sargs;
          modules = modules ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager.users.ben.home.stateVersion = "24.11";
            }
            {
              home-manager = {
                extraSpecialArgs = sargs;
                # useGlobalPkgs = true;
                useUserPackages = true;
                users.ben = hm;
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
        loqnux = sys {
          modules = [ ./os/loqnux ];
          hm = import ./hm/loqnux;
        };
        wsl = sys {
          modules = [
            nixos-wsl.nixosModules.default
            ./os/wsl
          ];
          hm = import ./hm/wsl;
        };
      };

      homeConfigurations = {
        home = {
          inherit pkgs;
          extraSpecialArgs = sargs;
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
