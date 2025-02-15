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
      pkgs = import nixpkgs { inherit system; };
      sargs = {
        inherit inputs outputs;
        inherit (kirsch.packages.${system}) kirsch;
        inherit (anakron.packages.${system}) anakron;
        inherit (apple-fonts.packages.${system}) sf-pro ny;
        scheme = {
          base00 = "#000000";
          base01 = "#141f1f";
          base02 = "#1f3030";
          base03 = "#294040";
          base04 = "#527a7a";
          base05 = "#c2d6d6";
          base06 = "#c6d8d8";
          base07 = "#c9dada";
          base08 = "#ed6883";
          base09 = "#ef702e";
          base0A = "#fcc06c";
          base0B = "#53b26c";
          base0C = "#00edd0";
          base0D = "#74b9ff";
          base0E = "#ab80ef";
          base0F = "#d4c2f9";
        };
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
