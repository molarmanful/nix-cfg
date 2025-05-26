{ scheme, ... }:
{

  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    style =
      ''
        @define-color bg  ${scheme.base00};
        @define-color fg  ${scheme.base05};
        @define-color sep ${scheme.base01};

        @define-color bg-focused  ${scheme.base00};
        @define-color fg-focused  ${scheme.base07};
        @define-color bg-active   ${scheme.base01};
        @define-color fg-active   ${scheme.base0D};
        @define-color bg-inactive ${scheme.base01};
        @define-color fg-inactive ${scheme.base04};
        @define-color bg-urgent   ${scheme.base00};
        @define-color fg-urgent   ${scheme.base09};
        @define-color bg-binding  ${scheme.base00};
        @define-color fg-binding  ${scheme.base0E};

        @define-color fg-good     ${scheme.base0B};
        @define-color fg-degraded ${scheme.base0A};
        @define-color fg-bad      ${scheme.base08};
      ''
      + (builtins.readFile ./waybar.css);
    settings = [
      {

        position = "bottom";
        margin-right = 13;
        margin-left = 13;
        margin-bottom = 13;
        spacing = 0;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "river/tags"
          "river/mode"
        ];

        modules-center = [
          "sway/window"
          "river/window"
        ];

        modules-right = [
          "network"
          "cpu"
          "memory"
          "temperature"
          "wireplumber"
          "backlight"
          "battery"
          "clock"
        ];

        "river/tags" = {
          hide-vacant = true;
        };

        "sway/window" = {
          max-length = 65;
        };

        "river/window" = {
          max-length = 65;
        };

        network = {
          format-wifi = "󰖩 ({signalStrength}%) {essid}";
          format-ethernet = "{ipaddr}/{cidr} 󱐋";
          tooltip-format = "{ifname} via {gwaddr} 󰀂";
          format-linked = "{ifname} (No IP) 󰌷";
          format-disconnected = "disconnected ⚠";
        };

        cpu = {
          states = {
            warning = 60;
            critical = 80;
          };
          interval = 1;
          format = "CPU {usage}%";
        };

        temperature = {
          critical-threshold = 80;
          format-critical = "󱃂 {temperatureC}°C";
          format = "󰔏 {temperatureC}°C";
        };

        memory = {
          states = {
            warning = 70;
            critical = 90;
          };
          interval = 1;
          format = "MEM {}%";
        };

        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "󰝟";
          on-click = "helvum";
          format-icons = [
            ""
            ""
          ];
        };

        backlight = {
          reverse-scrolling = true;
          format = "{icon} {percent}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          interval = 1;
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        clock = {
          interval = 30;
          format = "{:%a, %b %d %Y | %I:%M %p}";
          tooltip-format = "{calendar}";
        };

      }
    ];

  };
}
