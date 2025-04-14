{
  config,
  inputs,
  pkgs,
  lib,
  secretspath,
  ...
}:
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = [ inputs.nixpkgs-wayland.overlay ];
  };

  networking.hostName = lib.mkDefault "jimbo";

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
      options = "--delete-older-than 1w";
    };
  };

  boot.loader.systemd-boot.configurationLimit = 10;

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      ben-password.neededForUsers = true;
    };
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
      ];
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  programs = {
    fish.enable = true;
    nix-ld.enable = true;
    ssh.startAgent = true;

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };

  services = {
    openssh.enable = true;
  };

}
