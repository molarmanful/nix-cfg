{ lib, pkgs, ... }: {

  networking.hostName = lib.mkDefault "jimbo";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;

  boot.loader.systemd-boot.configurationLimit = 10;

  programs.fish.enable = true;
  environment.pathsToLink = ["/share/fish"];
  environment.shells = [pkgs.fish];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ben = import ../hm/default.nix;
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
