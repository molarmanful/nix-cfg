{
  pkgs,
  mypkgs,
  scheme,
  ...
}:
{

  imports = [
    ../wayland
    ../tofi
    ../waybar
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
    swaybg
    wideriver
    shotman
    mypkgs.river-bedload
  ];

  wayland.windowManager.river = {

    enable = true;
    extraConfig =
      let
        hexes = builtins.mapAttrs (_: v: "0x${builtins.substring 1 (-1) v}") scheme;
      in
      ''
        ${builtins.readFile ./cfg/keys.sh}
        echo 'KEYS done'
        ${builtins.readFile ./cfg/config.sh}
        echo 'CONFIG done'
        ${builtins.readFile ./cfg/apps.sh}
        echo 'APPS done'

        riverctl background-color ${hexes.base00}
        riverctl border-color-focused ${hexes.base03}
        riverctl border-color-unfocused ${hexes.base01}
        riverctl border-width 1

        riverctl default-layout wideriver
        wideriver \
          --inner-gap 13 --outer-gap 13 --no-smart-gaps \
          --border-width 1 --border-width-monocle 1 \
          --border-color-focused ${hexes.base03} \
          --border-color-focused-monocle ${hexes.base03} \
          --border-color-unfocused ${hexes.base01} \
          > ~/wideriver.log 2>&1 &

        echo 'LAYOUT done'

        riverctl spawn 'swaybg -m fit -c 000000 -i ${../../../wp/skull.png}'
        riverctl spawn kanshi
        riverctl spawn swaync
        riverctl spawn waybar
        riverctl spawn ssh-add

        riverctl focus-output DP-9
        riverctl set-focused-tags $((1 << 8))
        riverctl focus-output eDP-1
        riverctl set-focused-tags $((1 << 1))

        riverctl spawn floorp
        riverctl spawn dev.vencord.Vesktop
        riverctl spawn slack
        riverctl spawn md.obsidian.Obsidian
        riverctl spawn alacritty

        echo 'ALL done'
      '';

  };
}
