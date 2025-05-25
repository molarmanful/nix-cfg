{
  upkgs,
  ...
}:

{
  imports = [
    ../.
    ../flatpak
    ../river
    ../wezterm
    ../foot
    ../alacritty
    ../godot
    ../melee
    ../floorp
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
