{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-24.11";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    kirsch.url = "github:molarmanful/kirsch";
    anakron.url = "github:molarmanful/ANAKRON";
    abyssal.url = "github:molarmanful/abyssal";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      stylix,
      apple-fonts,
      kirsch,
      anakron,
      ...
    }@inputs:
    let

      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mypkgs = {
        cozette = pkgs.callPackage ./mypkgs/cozette.nix { };
        beekeeper = pkgs.callPackage ./mypkgs/beekeeper.nix { };
      };
      sargs = {
        inherit inputs outputs;
        inherit (kirsch.packages.${system}) kirsch;
        inherit (anakron.packages.${system}) anakron;
        inherit (apple-fonts.packages.${system}) sf-pro ny;
        inherit mypkgs;
        scheme = inputs.abyssal.lib.stylix;
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
          modules = [
            stylix.nixosModules.stylix
            ./os/loqnux
          ];
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
