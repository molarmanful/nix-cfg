{ inputs, upkgs, ... }:
{

  imports = [
    ./git
    ./jujutsu
    ./sops
    ./ssh
    ./direnv
    ./fish
    ./nixcats
    ./rclone
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
      neofetch
      dasel
      bitwarden-cli
      bws
      age
      sqlite
      distrobox
      azure-cli
      sops
      claude-code
    ];
  };

  programs.home-manager.enable = true;
}
