{ upkgs, ... }:
{

  imports = [
    ../common
    ./git
    ./direnv
    ./fish
    ./nixcats
  ];

  home = {
    username = "ben";
    homeDirectory = "/home/ben";

    packages = with upkgs; [
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
      rclone
      dasel
    ];
  };

  programs.home-manager.enable = true;
}
