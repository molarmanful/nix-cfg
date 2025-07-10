{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    stylix.url = "github:danth/stylix";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    persway.url = "github:johnae/persway";
    slippi.url = "github:molarmanful/slippi-nix";
    jjui.url = "github:idursun/jjui";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    kirsch.url = "github:molarmanful/kirsch";
    ANAKRON.url = "github:molarmanful/ANAKRON";
    QUINTESSON.url = "github:molarmanful/QUINTESSON";
    abyssal.url = "github:molarmanful/abyssal";

    secrets.url = "git+https://github.com/molarmanful/nix-secrets?shallow=1";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;

      imports = [ flake-parts.flakeModules.modules ];

      systems = [ ];

      flake =
        let

          system = "x86_64-linux";
          stateVersion = "25.05";

          pkgs = inputs.nixpkgs.legacyPackages.${system};
          upkgs = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          nur = inputs.nur.legacyPackages.${system};
          spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
          mypkgs = {
            river = upkgs.callPackage ./mypkgs/river { };
            keyb0xx = upkgs.callPackage ./mypkgs/keyb0xx { };
            river-bedload = upkgs.callPackage ./mypkgs/river-bedload { };
            libratbag = upkgs.callPackage ./mypkgs/libratbag { };
          };

          commonModules = [
            { system = { inherit stateVersion; }; }
            { programs.nix-index-database.comma.enable = true; }
          ];

          specialArgs = {
            inherit
              stateVersion
              inputs
              upkgs
              mypkgs
              nur
              spicePkgs
              ;
            inherit (inputs.kirsch.packages.${system}) kirsch;
            inherit (inputs.ANAKRON.packages.${system}) ANAKRON;
            inherit (inputs.QUINTESSON.packages.${system}) QUINTESSON;
            inherit (inputs.apple-fonts.packages.${system}) sf-pro ny;
            scheme = inputs.abyssal.lib.stylix;
            persway = inputs.persway.packages.${system}.default;
            jjui = inputs.jjui.packages.${system}.default;
            secretspath = builtins.toString inputs.secrets;
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
                  modules =
                    commonModules
                    ++ modules
                    ++ [
                      inputs.home-manager.nixosModules.home-manager
                      inputs.nix-index-database.nixosModules.nix-index
                      inputs.sops-nix.nixosModules.sops
                      inputs.nix-flatpak.nixosModules.nix-flatpak
                      inputs.stylix.nixosModules.stylix
                      inputs.slippi.nixosModules.default
                      {
                        home-manager = {
                          inherit extraSpecialArgs;
                          # useGlobalPkgs = true;
                          useUserPackages = true;
                          backupFileExtension = "backup";
                          users.ben = hm;
                        };
                      }
                      { home-manager.users.ben.home = { inherit stateVersion; }; }
                    ];
                };

            in
            {
              ifwit = sys {
                modules = [
                  inputs.nixos-hardware.nixosModules.framework-16-7040-amd
                  ./os/ifwit
                ];
                hm = import ./hm/ifwit;
              };

              loqnux = sys {
                modules = [ ./os/loqnux ];
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
              inherit pkgs extraSpecialArgs;
              modules = commonModules ++ [
                inputs.nix-index-database.hmModules.nix-index
                ./hm
              ];
            };
          };

        };
    };
}
