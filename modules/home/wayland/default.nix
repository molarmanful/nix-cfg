{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard-rs
    wl-clip-persist
    pavucontrol
    pw-volume
    helvum
    playerctl
  ];
}
