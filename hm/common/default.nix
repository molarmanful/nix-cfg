{ inputs, upkgs, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    ./fish
    ./git
    ./jujutsu
    ./sops
    ./ssh
    ./direnv
    ./nvim
    ./rclone
    ./bacon
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = [ inputs.nixpkgs-wayland.overlay ];
  };

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
      fastfetch
      dasel
      bitwarden-cli
      bws
      age
      sqlite
      distrobox
      azure-cli
      sops
    ];
  };

  programs = {
    home-manager.enable = true;
    nix-index-database.comma.enable = true;
  };
}
