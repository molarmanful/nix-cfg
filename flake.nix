{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

    stylix.url = "github:danth/stylix/release-24.11";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    persway.url = "github:johnae/persway";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    slippi.url = "github:molarmanful/slippi-nix";
    jjui.url = "github:idursun/jjui";
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
          stateVersion = "24.11";

          pkgs = inputs.nixpkgs.legacyPackages.${system};
          upkgs = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          mypkgs = {
            beekeeper = upkgs.callPackage ./mypkgs/beekeeper.nix { };
            keyb0xx = upkgs.callPackage ./mypkgs/keyb0xx { };
            river-bedload = upkgs.callPackage ./mypkgs/river-bedload { };
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
              ;
            inherit (inputs.kirsch.packages.${system}) kirsch;
            inherit (inputs.ANAKRON.packages.${system}) ANAKRON;
            inherit (inputs.QUINTESSON.packages.${system}) QUINTESSON;
            inherit (inputs.apple-fonts.packages.${system}) sf-pro ny;
            scheme = inputs.abyssal.lib.stylix;
            persway = inputs.persway.packages.${system}.default;
            wezterm = inputs.wezterm.packages.${system}.default;
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
