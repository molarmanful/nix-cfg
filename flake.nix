{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    slippi.url = "github:molarmanful/slippi-nix";
    kirsch.url = "github:molarmanful/kirsch";
    ANAKRON.url = "github:molarmanful/ANAKRON";
    QUINTESSON.url = "github:molarmanful/QUINTESSON";
    abyssal.url = "github:molarmanful/abyssal";

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
          upkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
          mypkgs = {
            beekeeper = upkgs.callPackage ./mypkgs/beekeeper.nix { };
            keyb0xx = upkgs.callPackage ./mypkgs/keyb0xx { };
            river-bedload = upkgs.callPackage ./mypkgs/river-bedload { };
          };
          specialArgs = {
            inherit inputs upkgs mypkgs;
            inherit (inputs.kirsch.packages.${system}) kirsch;
            inherit (inputs.ANAKRON.packages.${system}) ANAKRON;
            inherit (inputs.QUINTESSON.packages.${system}) QUINTESSON;
            inherit (inputs.apple-fonts.packages.${system}) sf-pro ny;
            scheme = inputs.abyssal.lib.stylix;
            persway = inputs.persway.packages.${system}.default;
            wezterm = inputs.wezterm.packages.${system}.default;
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
