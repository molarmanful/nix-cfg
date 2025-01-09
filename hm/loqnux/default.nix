{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway.nix
  ];

  home.packages = with pkgs; [
    wezterm
    floorp
  ];

  programs.waybar.enable = true;
  programs.qt5ct.enable = true;
}
