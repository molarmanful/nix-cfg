{
  pkgs,
  scheme,
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
  ];

  wayland.windowManager.sway = {

    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      bars = [ ];
      keybindings = { };
    };
    extraOptions = [ "--unsupported-gpu" ];
    extraConfig = ''
      client.focused          ${scheme.base01} ${scheme.base00} ${scheme.base07} ${scheme.base01} ${scheme.base01}
      client.focused_inactive ${scheme.base01} ${scheme.base00} ${scheme.base0D} ${scheme.base01} ${scheme.base01}
      client.unfocused        ${scheme.base01} ${scheme.base01} ${scheme.base04} ${scheme.base01} ${scheme.base01}
      client.urgent           ${scheme.base01} ${scheme.base00} ${scheme.base09} ${scheme.base01} ${scheme.base01}
      client.placeholder      ${scheme.base01} ${scheme.base00} ${scheme.base04} ${scheme.base01} ${scheme.base01}

      client.background       ${scheme.base00}

      ${builtins.readFile ./cfg/pre}
      ${builtins.readFile ./cfg/keys}
      ${builtins.readFile ./cfg/config}
      ${builtins.readFile ./cfg/apps}
    '';

  };
}
