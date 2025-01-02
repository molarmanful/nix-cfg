{ pkgs, ... }: {

  imports = [
    ./git
    # ./neovim
  ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # FIXME: remove
    neovim
    zip
    xz
    unzip
    p7zip
    ripgrep
    jq
    fzf
    file
    which
    tree
    gnused
    gnutar
    gawk
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
  ];

  programs.home-manager.enable = true;
}
