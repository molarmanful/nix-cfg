{
  pkgs,
  upkgs,
  mypkgs,
  ...
}:

{
  imports = [
    ../.
    ../kanshi
    ../river
    ../wezterm
    ../foot
    ../godot
    ../melee
    ../floorp
  ];

  home.packages = with upkgs; [
    chromium
    libsForQt5.qt5ct
    pkgs.vesktop
    pkgs.obsidian
    # zoom-us
    distrobox
    azure-cli
    sops
    obs-studio
    obs-studio-plugins.wlrobs
    spotify-player
    feh
    mypkgs.beekeeper
    sqlite
    bluetuith
    pavucontrol
    pw-volume
    helvum
    wl-clipboard-rs
    wl-clip-persist
    playerctl
    krita
    bitwarden-desktop
  ];
}
