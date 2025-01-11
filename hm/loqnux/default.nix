{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway
    ../wezterm
    ../thunnar.nix
  ];

  home.packages = with pkgs; [
    floorp
    chromium
    libsForQt5.qt5ct
    discord
    obsidian
    zoom-us
    godot_4
    distrobox
  ];
}
