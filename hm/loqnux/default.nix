{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway
    ../wezterm
  ];

  home.packages = with pkgs; [
    floorp
    libsForQt5.qt5ct
    discord
  ];
}
