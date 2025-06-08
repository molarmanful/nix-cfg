{ config, upkgs, ... }:
{

  sops.secrets.rclone = { };

  home.packages = with upkgs; [ rclone ];

  xdg.configFile."rclone/rclone.conf".source =
    config.lib.file.mkOutOfStoreSymlink config.sops.secrets.rclone.path;
}
