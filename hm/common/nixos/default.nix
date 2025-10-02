{
  pkgs,
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
    ../spicetify
  ];

  home = {
    packages = with upkgs; [
      chromium
      libsForQt5.qt5ct
      obs-studio
      obs-studio-plugins.wlrobs
      feh
      bluetuith
      krita
      bitwarden-desktop
      quickemu
      slack
    ];

    file.".XCompose".source = "${pkgs.keyd}/share/keyd/keyd.compose";
  };
}
