{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway.nix
  ];

  home.packages = with pkgs; [
    wezterm
    floorp
    libsForQt5.qt5ct
  ];

  programs.waybar.enable = true;
}
