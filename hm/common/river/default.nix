{
  lib,
  config,
  pkgs,
  mypkgs,
  scheme,
  ...
}:
{

  imports = [
    ../wayland
    ../way-displays
    ../tofi
    ../waybar
  ];

  options.wayland.windowManager.river = {
    touchpadScrollFactor = lib.mkOption {
      type = lib.types.numbers.nonnegative;
      default = 0.2;
    };
  };

  config = {
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
          cfg = config.wayland.windowManager.river;
        in
        ''
          TOUCHPAD_SCROLL_FACTOR=${toString cfg.touchpadScrollFactor}
          OUTPUTS=$(river-bedload -print outputs)
          DP_INTERNAL=$(echo $OUTPUTS | jq -r '.[].name | first(select(startswith("eDP-")))')
          DP_EXTERNAL=$(echo $OUTPUTS | jq -r '.[].name | first(select(startswith("DP-")))')

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
          riverctl spawn way-displays
          riverctl spawn swaync
          riverctl spawn waybar
          riverctl spawn ssh-add

          riverctl focus-output $DP_EXTERNAL
          riverctl set-focused-tags $((1 << 8))
          riverctl focus-output $DP_INTERNAL
          riverctl set-focused-tags $((1 << 1))

          riverctl spawn floorp
          riverctl spawn dev.vencord.Vesktop
          riverctl spawn slack
          riverctl spawn md.obsidian.Obsidian
          riverctl spawn alacritty

          echo 'ALL done'
        '';

    };
  };
}
