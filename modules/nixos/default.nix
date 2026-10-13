{
  flake,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.sops-nix.nixosModules.sops
  ];

  nixpkgs = {
    overlays = [
      inputs.nixpkgs-wayland.overlay
    ]
    ++ lib.attrValues self.overlays;
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://cache.iog.io"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 0;
      systemd-boot.configurationLimit = 10;
    };
  };

  sops = {
    defaultSopsFile = "${inputs.secrets}/secrets.yaml";

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets.ben-password.neededForUsers = true;
  };

  environment = {
    pathsToLink = [ "/share/fish" ];
    shells = [ pkgs.fish ];
  };

  users = {
    mutableUsers = false;

    users.ben = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.ben-password.path;
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "video"
        "input"
      ];
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    daemon.settings = {
      fixed-cidr-v6 = "fd00::/80";
      ipv6 = true;
    };
  };

  programs = {
    fish.enable = true;
    nix-ld.enable = true;
    ssh.startAgent = true;

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    nix-index-database.comma.enable = true;
  };

  services.openssh.enable = true;

  home-manager = {
    # useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
