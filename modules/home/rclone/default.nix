{ config, pkgs, ... }:
{

  sops.secrets.rclone = { };

  home.packages = with pkgs; [ rclone ];

  xdg.configFile."rclone/rclone.conf".source =
    config.lib.file.mkOutOfStoreSymlink config.sops.secrets.rclone.path;
}
