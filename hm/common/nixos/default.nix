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
    krita
    bitwarden-desktop
    quickemu
    slack
  ];
}
