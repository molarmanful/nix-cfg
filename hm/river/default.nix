{ pkgs, scheme, ... }:
{

  imports = [
    ../tofi
    ../waybar
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
    swaybg
  ];

  wayland.windowManager.river = {

    enable = true;
    extraConfig = ''
      riverctl background-color ${scheme.base00}
      riverctl border-color-focused ${scheme.base02}
      riverctl border-color-unfocused ${scheme.base01}

      swaybg -m fit -c 000000 -i ${../../wp/skull.png}

      ${builtins.readFile ./cfg/keys.sh}
      ${builtins.readFile ./cfg/config.sh}
      ${builtins.readFile ./cfg/apps.sh}
    '';

  };
}
