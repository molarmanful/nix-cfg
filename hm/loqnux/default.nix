{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway.nix
    ./wezterm
  ];

  home.packages = with pkgs; [
    floorp
    libsForQt5.qt5ct
  ];

  programs.waybar.enable = true;
}
