{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
