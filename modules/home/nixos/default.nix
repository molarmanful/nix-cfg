{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in

{
  imports = [
    self.homeModules.default
    self.homeModules.flatpak
    self.homeModules.river
    self.homeModules.alacritty
    self.homeModules.floorp
    self.homeModules.easyeffects
  ];

  home = {
    packages = with pkgs; [
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
      lsfg-vk
      claude-code
    ];

    file.".XCompose".source = "${pkgs.keyd}/share/keyd/keyd.compose";

    stateVersion = "25.11";
  };
}
