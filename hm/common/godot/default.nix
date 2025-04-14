{ config, ... }:
{
  xdg.configFile."godot/editor_settings-4.3.tres".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-cfg/cfg/godot/editor_settings-4.3.tres";
  xdg.configFile."godot/editor_settings-4.4.tres".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-cfg/cfg/godot/editor_settings-4.4.tres";
}
