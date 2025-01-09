{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "wezterm";
      startup = [ ];
    };
    extraConfig = ''
      input "type:touchpad" {
        natural_scroll enabled
        scroll_factor 0.5
        click_method clickfinger
        dwt enabled
        dwtp enabled
      }
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
