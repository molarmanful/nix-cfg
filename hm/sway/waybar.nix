{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
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
        ];

        modules-center = [
          "sway/window"
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

        "sway/window" = {
          max-length = 65;
        };

        network = {
          format-wifi = " ({signalStrength}%) {essid}";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} 󰀂";
          format-linked = "{ifname} (No IP) ";
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
          format-critical = " {temperatureC}°C";
          format = " {temperatureC}°C";
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
          format-muted = "婢";
          on-click = "helvum";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        backlight = {
          reverse-scrolling = true;
          format = "{icon} {percent}";
          format-icons = [
            "🌑"
            "🌒"
            "🌓"
            "🌔"
            "🌕"
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
          format = "{:%a, %b %d %Y | %I:%M %p}";
          tooltip-format = "{calendar}";
        };

      }
    ];

  };
}
