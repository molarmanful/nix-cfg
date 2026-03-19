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
    ../alacritty
    ../godot
    ../floorp
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
      mypkgs.lsfg-vk
      claude-code
    ];

    file.".XCompose".source = "${pkgs.keyd}/share/keyd/keyd.compose";
  };
}
