{
  pkgs,
  ...
}:

{
  stylix.targets.alacritty.enable = false;
  home.packages = with pkgs; [ alacritty ];
}
