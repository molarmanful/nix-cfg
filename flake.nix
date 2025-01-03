{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvchad-starter = {
      url = "github:molarmanful/nvim-cfg";
      flake = false;
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };

  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: 
    let
      inherit (self) outputs;

      addendum = {
        system.stateVersion = "24.05";
      };

      sys = modules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs outputs; };
        modules = modules ++ [
          home-manager.nixosModules.home-manager
	  {
            home-manager = {
	      extraSpecialArgs = { inherit inputs outputs; };
              # useGlobalPkgs = true;
              useUserPackages = true;
              users.ben = import ./hm/default.nix;
            };
	  }
	  addendum
        ];
      };

    in {
      nixosConfigurations = {

        linux = sys [ ./os/linux ];

        wsl = sys [ 
          nixos-wsl.nixosModules.default
	  ./os/wsl
	];

      };
      homeConfigurations = {

        home = {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
	  extraSpecialArgs = { inherit inputs outputs; };
	  modules = [
            ./hm
	    addendum
          ];
	};

      };
    };
}
