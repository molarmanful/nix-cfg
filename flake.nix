{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-24.11";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    kirsch.url = "github:molarmanful/kirsch";
    ANAKRON.url = "github:molarmanful/ANAKRON";
    abyssal.url = "github:molarmanful/abyssal";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      nix-index-database,
      stylix,
      apple-fonts,
      kirsch,
      ANAKRON,
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
      specialArgs = {
        inherit inputs outputs mypkgs;
        inherit (kirsch.packages.${system}) kirsch;
        inherit (ANAKRON.packages.${system}) ANAKRON;
        inherit (apple-fonts.packages.${system}) sf-pro ny;
        scheme = inputs.abyssal.lib.stylix;
      };
      extraSpecialArgs = specialArgs;

      sys =
        { modules, hm }:
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = modules ++ [
            nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.users.ben.home.stateVersion = "24.11";
            }
            {
              home-manager = {
                inherit extraSpecialArgs;
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
          inherit extraSpecialArgs;
          modules = [
            ./hm
            nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            {
              system.stateVersion = "24.11";
            }
          ];
        };
      };

    };
}
