{ config, ... }:
{
  xdg.configFile."godot/editor_settings-4.3.tres".source =
    config.lib.file.mkOutOfStoreSymlink ./editor_settings-4.3.tres;
}
