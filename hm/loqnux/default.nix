{ pkgs, ... }:
{
  import = [
    ../.
    ../sway.nix
  ];

  home.packages = with pkgs; [
    wezterm
    floorp
  ];
}
