{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard-rs
    wl-clip-persist
    pavucontrol
    wireplumber
    crosspipe
    playerctl
  ];
}
