{
  pkgs,
  upkgs,
  mypkgs,
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
    ../easyeffects
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
      steamtinkerlaunch
      libstrangle
      mangohud
      protontricks
      nexusmods-app-unfree
      mypkgs.lsfg-vk
    ];

    file.".XCompose".source = "${pkgs.keyd}/share/keyd/keyd.compose";
  };
}
