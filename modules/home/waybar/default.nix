{
  config,
  ...
}:

{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;

    style =
      with config.lib.stylix.colors;
      ''
        @define-color bg  #${base00};
        @define-color fg  #${base05};
        @define-color sep #${base01};

        @define-color bg-focused  #${base00};
        @define-color fg-focused  #${base07};
        @define-color bg-active   #${base01};
        @define-color fg-active   #${base0D};
        @define-color bg-inactive #${base01};
        @define-color fg-inactive #${base04};
        @define-color bg-urgent   #${base00};
        @define-color fg-urgent   #${base09};
        @define-color bg-binding  #${base00};
        @define-color fg-binding  #${base0E};

        @define-color fg-good     #${base0B};
        @define-color fg-degraded #${base0A};
        @define-color fg-bad      #${base08};
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
          "river/tags"
          "river/mode"
        ];

        modules-center = [
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

        "river/window" = {
          max-length = 65;
        };

        network = {
          format-wifi = "󰖩 ({signalStrength}%) {essid}";
          format-ethernet = "󱐋 {ipaddr}/{cidr}";
          tooltip-format = "󰀂 {ifname} via {gwaddr}";
          format-linked = "󰌷 {ifname} (No IP)";
          format-disconnected = "⚠ disconnected";
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
          format = "{icon} {volume}%";
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
