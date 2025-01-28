{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    swaynotificationcenter
    pw-volume
    tofi
    sway-contrib.grimshot
    helvum
    wl-clipboard-rs
    wl-clip-persist
  ];

  wayland.windowManager.sway = {

    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      bars = [ ];
      keybindings = { };
    };
    extraConfig = ''
      ${builtins.readFile ./cfg/pre}
      ${builtins.readFile ./cfg/keys}
      ${builtins.readFile ./cfg/config}
    '';

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';

  };
}
