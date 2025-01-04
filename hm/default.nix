{ pkgs, ... }:
{

  imports = [
    ./git.nix
    ./direnv.nix
    ./fish.nix
    ./nixcats.nix
  ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
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

  programs.home-manager.enable = true;
}
