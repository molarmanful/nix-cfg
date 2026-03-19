{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    flake-parts.url = "github:hercules-ci/flake-parts";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    waybar.url = "github:Alexays/Waybar";
    yeetmouse = {
      url = "github:AndyFilter/YeetMouse?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kirsch.url = "github:molarmanful/kirsch";
    ANAKRON.url = "github:molarmanful/ANAKRON";
    QUINTESSON.url = "github:molarmanful/QUINTESSON";
    abyssal.url = "github:molarmanful/abyssal";

    secrets.url = "git+https://github.com/molarmanful/nix-secrets?shallow=1";

    nvim-plugins-jj-diffconflicts = {
      url = "github:rafikdraoui/jj-diffconflicts";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        flake-parts.flakeModules.modules
        inputs.wrappers.flakeModules.wrappers
      ];
      systems = [ "x86_64-linux" ];

      flake =
        let
          mkArgs =
            system:
            let
              stateVersion = "25.11";
              upkgs = import inputs.nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
              mypkgs = self.packages.${system} // {
                waybar = inputs.waybar.packages.${system}.default;
                lsfg-vk = upkgs.callPackage ./mypkgs/lsfg-vk { };
              };
              nur = inputs.nur.legacyPackages.${system};
            in
            {
              inherit
                stateVersion
                inputs
                upkgs
                mypkgs
                nur
                ;
              inherit (inputs.kirsch.packages.${system}) kirsch;
              inherit (inputs.ANAKRON.packages.${system}) ANAKRON;
              inherit (inputs.QUINTESSON.packages.${system}) QUINTESSON;
              inherit (inputs.apple-fonts.packages.${system}) sf-pro ny;
              secretspath = "${inputs.secrets}";
            };
        in

        {
          wrappers = {
            neovim = import ./modules/neovim inputs;
          };

          nixosConfigurations =
            let
              mkSys =
                system: module:
                inputs.nixpkgs.lib.nixosSystem {
                  inherit system;
                  specialArgs = mkArgs system;
                  modules = [ module ];
                };
            in
            {
              ifwit = mkSys "x86_64-linux" ./os/ifwit;
            };

          homeConfigurations =
            let
              extraSpecialArgs = mkArgs "x86_64-linux";
            in
            {
              home = {
                inherit extraSpecialArgs;
                inherit (extraSpecialArgs) pkgs;
                modules = [ ./hm ];
              };
            };
        };
    };
}
