{ pkgs, inputs, ... }: {

  imports = [
    ./git.nix
    # ./nvchad.nix
    ./nixcats.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [

      (final: prev: {
        nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
      })

      (final: prev: {
        nvim = inputs.nvim-cfg.packages."${pkgs.system}".default;
      })

    ];
  };

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # nvchad
    nvim
    zip
    xz
    unzip
    p7zip
    bat
    ripgrep
    repgrep
    fzf
    file
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
    nil
  ];

  programs.home-manager.enable = true;
}
