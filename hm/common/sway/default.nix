{
  config,
  pkgs,
  persway,
  ...
}:
{

  imports = [
    ../tofi
    ../waybar
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
    sway-contrib.grimshot
    persway
    swaybg
  ];

  programs = if config.programs ? spicetify then { spicetify.windowManagerPatch = true; } else { };

  wayland.windowManager.sway = {

    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      bars = [ ];
      keybindings = { };
    };
    extraOptions = [ "--unsupported-gpu" ];
    extraConfig = with config.lib.stylix.colors; ''
      client.focused          ${base01} ${base00} ${base07} ${base01} ${base01}
      client.focused_inactive ${base01} ${base00} ${base0D} ${base01} ${base01}
      client.unfocused        ${base01} ${base01} ${base04} ${base01} ${base01}
      client.urgent           ${base01} ${base00} ${base09} ${base01} ${base01}
      client.placeholder      ${base01} ${base00} ${base04} ${base01} ${base01}

      client.background       ${base00}

      ${builtins.readFile ./cfg/pre}
      ${builtins.readFile ./cfg/keys}
      ${builtins.readFile ./cfg/config}
      ${builtins.readFile ./cfg/apps}
    '';

  };
}
