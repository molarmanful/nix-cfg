{ pkgs, ... }:
{

  imports = [
    ./git
    ./direnv
    ./fish
    ./nixcats
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "ben";
    homeDirectory = "/home/ben";

    packages = with pkgs; [
      bashInteractive
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
      bottom
      neofetch
    ];
  };

  programs.home-manager.enable = true;
}
