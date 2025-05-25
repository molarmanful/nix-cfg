{ upkgs, ... }:
{

  home.packages = with upkgs; [
    wl-clipboard-rs
    wl-clip-persist
    pavucontrol
    pw-volume
    helvum
    playerctl
  ];
}
