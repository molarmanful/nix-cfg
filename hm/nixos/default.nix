{
  upkgs,
  ...
}:

{
  imports = [
    ../common
    ../common/kanshi
    ../common/river
    ../common/wezterm
    ../common/foot
    ../common/alacritty
    ../common/godot
    ../common/melee
    ../common/floorp
  ];

  home.packages = with upkgs; [
    chromium
    libsForQt5.qt5ct
    obs-studio
    obs-studio-plugins.wlrobs
    spotify-player
    feh
    bluetuith
    pavucontrol
    pw-volume
    helvum
    wl-clipboard-rs
    wl-clip-persist
    playerctl
    krita
    bitwarden-desktop
    quickemu
    slack
  ];
}
