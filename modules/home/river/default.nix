{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../wayland
    ../way-displays
    ../fuzzel
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
      wlr-randr
    ];

    wayland.windowManager.river = {
      enable = true;

      extraConfig =
        let
          hexes = builtins.mapAttrs (_: v: "0x${v}") config.lib.stylix.colors;
          cfg = config.wayland.windowManager.river;
        in
        /* bash */ ''
          TOUCHPAD_SCROLL_FACTOR=${toString cfg.touchpadScrollFactor}
          OUTPUTS=$(wlr-randr --json)
          DP_INTERNAL=$(echo $OUTPUTS | jq -r '.[].name | first(select(startswith("eDP-")))')
          DP_EXTERNAL=$(echo $OUTPUTS | jq -r '.[].name | first(select(startswith("DP-")))')
          COLOR_BG=${hexes.base00}
          COLOR_FOC=${hexes.base03}
          COLOR_UNFOC=${hexes.base01}

          systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river

          ${builtins.readFile ./cfg/keys.sh}
          echo 'KEYS done'
          ${builtins.readFile ./cfg/config.sh}
          echo 'CONFIG done'
          ${builtins.readFile ./cfg/apps.sh}
          echo 'APPS done'
          ${builtins.readFile ./cfg/layout.sh}
          echo 'LAYOUT done'

          riverctl spawn 'swaybg -m fit -c 000000 -i ${../../stylix/skull.png}'
          rm -f /tmp/way-displays.pid /tmp/way-displays.$XDG_VTNR.pid
          riverctl spawn way-displays
          riverctl spawn swaync
          riverctl spawn waybar
          riverctl spawn ssh-add

          riverctl focus-output $DP_INTERNAL
          riverctl set-focused-tags $((1 << 8))
          riverctl focus-output $DP_EXTERNAL
          riverctl set-focused-tags $((1 << 1))

          riverctl spawn floorp
          riverctl spawn vesktop
          riverctl spawn slack
          riverctl spawn md.obsidian.Obsidian
          riverctl spawn alacritty

          echo 'ALL done'
        '';
    };
  };
}
