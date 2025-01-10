{ pkgs, ... }:
{

  home.packages = with pkgs; [
    grim
    slurp
    tofi
  ];

  wayland.windowManager.sway = {

    enable = true;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "tofi-drun";
      defaultWorkspace = "1";
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
      background-color = "#000a";
      hint-font = false;
      ascii-input = true;
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        margin-right = 8;
        margin-left = 8;
        margin-bottom = 8;
      }
    ];
    style = ./waybar.css;
  };

}
