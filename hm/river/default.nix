{ pkgs, scheme, ... }:

let
  hexes = builtins.mapAttrs (_: v: "0x${builtins.substring 1 (-1) v}") scheme;
in

{

  imports = [
    ../tofi
    ../waybar
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
    sway-contrib.grimshot
    swaybg
    wideriver
  ];

  wayland.windowManager.river = {

    enable = true;
    extraConfig = ''
      ${builtins.readFile ./cfg/keys.sh}
      echo 'KEYS done'
      ${builtins.readFile ./cfg/config.sh}
      echo 'CONFIG done'
      ${builtins.readFile ./cfg/apps.sh}
      echo 'APPS done'

      riverctl background-color ${hexes.base00}
      riverctl border-color-focused ${hexes.base02}
      riverctl border-color-unfocused ${hexes.base01}
      riverctl border-width 1

      riverctl default-layout wideriver
      riverctl default-attach-mode bottom
      wideriver \
        --inner-gap 13 --outer-gap 13 --no-smart-gaps \
        --border-width 1 --border-width-monocle 1 \
        --border-color-focused ${hexes.base02} \
        --border-color-focused-monocle ${hexes.base02} \
        --border-color-unfocused ${hexes.base01} \
        > tee ~/wideriver.log 2>&1 &

      echo 'LAYOUT done'

      riverctl spawn 'swaybg -m fit -c 000000 -i ${../../wp/skull.png}'
      riverctl spawn kanshi
      riverctl spawn swaync
      riverctl spawn waybar

      riverctl spawn floorp
      riverctl spawn vesktop
      riverctl spawn obsidian

      riverctl focus-output DP-9
      riverctl set-focused-tags $((1 << 8))
      riverctl focus-output eDP-1
      riverctl set-focused-tags $((1 << 1))

      echo 'ALL done'
    '';

  };
}
