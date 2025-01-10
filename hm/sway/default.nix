{ pkgs, ... }:
{

  home.packages = with pkgs; [
    tofi
    grim
    slurp
    helvum
  ];

  wayland.windowManager.sway = {

    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "tofi-drun";
      defaultWorkspace = "1";
      bars = [ { command = "swaybar_command waybar"; } ];
    };

    extraConfig = builtins.readFile ./config;

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';

  };

  programs.tofi = {
    enable = true;
    settings = {
      prompt-text = "> ";
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      font = "monospace";
      background-color = "#000A";
      foreground-color = "#CDCECF";
      selection-color = "#86ABDC";
      hint-font = false;
      ascii-input = true;
    };
  };

  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = [
      {

        position = "bottom";
        margin-right = 13;
        margin-left = 13;
        margin-bottom = 13;
        spacing = 1;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/window"
        ];

        modules-right = [
          "network"
          "cpu"
          "memory"
          "temperature"
          "wireplumber"
          "battery"
          "clock"
        ];

        network = {
          format-wifi = " {signalStrength}% @ {essid}";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} 󰀂";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "disconnected ⚠";
        };

        cpu = {
          interval = 1;
          format = "CPU {usage}%";
        };

        temperature = {
          critical-threshold = 80;
          format-critical = " {temperatureC}°C";
          format = " {temperatureC}°C";
        };

        memory = {
          interval = 1;
          format = "MEM {}%";
        };

        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "婢";
          on-click = "helvum";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          interval = 1;
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        clock = {
          interval = 30;
          format = "{:%a, %b %d %Y @ %H:%M %p}";
        };

      }
    ];

  };

}
