{ lib, pkgs, ... }:
{

  networking.hostName = lib.mkDefault "jimbo";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  boot.loader.systemd-boot.configurationLimit = 10;

  programs.fish.enable = true;
  environment = {
    pathsToLink = [ "/share/fish" ];
    shells = [ pkgs.fish ];
  };

  users.users.ben = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

}
