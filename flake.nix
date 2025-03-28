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
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    stylix.url = "github:danth/stylix/release-24.11";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    persway.url = "github:johnae/persway";
    slippi.url = "github:molarmanful/slippi-nix";
    kirsch.url = "github:molarmanful/kirsch";
    ANAKRON.url = "github:molarmanful/ANAKRON";
    QUINTESSON.url = "github:molarmanful/QUINTESSON";
    abyssal.url = "github:molarmanful/abyssal";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ flake-parts.flakeModules.modules ];

      systems = [ ];

      flake =
        let

          system = "x86_64-linux";
          stateVersion = "24.11";

          pkgs = inputs.nixpkgs.legacyPackages.${system};
          mypkgs = {
            cozette = pkgs.callPackage ./mypkgs/cozette.nix { };
            beekeeper = pkgs.callPackage ./mypkgs/beekeeper.nix { };
            keyb0xx = pkgs.callPackage ./mypkgs/keyb0xx { };
          };
          specialArgs = {
            inherit inputs mypkgs;
            inherit (inputs.kirsch.packages.${system}) kirsch;
            inherit (inputs.ANAKRON.packages.${system}) ANAKRON;
            inherit (inputs.QUINTESSON.packages.${system}) QUINTESSON;
            inherit (inputs.apple-fonts.packages.${system}) sf-pro ny;
            scheme = inputs.abyssal.lib.stylix;
            persway = inputs.persway.packages.${system}.default;
          };
          extraSpecialArgs = specialArgs;

        in
        {

          nixosConfigurations =
            let

              sys =
                { modules, hm }:
                inputs.nixpkgs.lib.nixosSystem {
                  inherit system specialArgs;
                  modules = modules ++ [
                    {
                      config = {
                        nix.settings = {
                          trusted-public-keys = [
                            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                            "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                          ];
                          substituters = [
                            "https://cache.nixos.org"
                            "https://nixpkgs-wayland.cachix.org"
                          ];
                        };
                        nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
                      };
                    }
                    inputs.nix-index-database.nixosModules.nix-index
                    { programs.nix-index-database.comma.enable = true; }
                    inputs.home-manager.nixosModules.home-manager
                    {
                      home-manager = {
                        inherit extraSpecialArgs;
                        # useGlobalPkgs = true;
                        useUserPackages = true;
                        backupFileExtension = "backup";
                        users.ben = hm;
                      };
                    }
                    {
                      home-manager.users.ben.home = { inherit stateVersion; };
                      system = { inherit stateVersion; };
                    }
                  ];
                };

            in
            {
              loqnux = sys {
                modules = [
                  inputs.stylix.nixosModules.stylix
                  inputs.slippi.nixosModules.default
                  ./os/loqnux
                ];
                hm = import ./hm/loqnux;
              };
              wsl = sys {
                modules = [
                  inputs.nixos-wsl.nixosModules.default
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
                inputs.nix-index-database.hmModules.nix-index
                { programs.nix-index-database.comma.enable = true; }
                { system = { inherit stateVersion; }; }
              ];
            };
          };

        };
    };

}
