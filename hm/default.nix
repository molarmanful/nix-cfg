{ pkgs, ... }:
{

  imports = [
    ./git.nix
    ./direnv.nix
    ./fish.nix
    ./nixcats.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "ben";
    homeDirectory = "/home/ben";

    packages = with pkgs; [
      zip
      xz
      unzip
      p7zip
      bat
      ripgrep
      repgrep
      fzf
      file
      fd
      which
      tree
      gnused
      gnutar
      gawk
      jq
      zstd
      gnupg
      nix-output-monitor
      nix-du
      btop
      iotop
      iftop
      strace
      ltrace
      lsof
      sysstat
      lm_sensors
      ethtool
      pciutils
      usbutils
      just
    ];
  };

  programs.home-manager.enable = true;
}
