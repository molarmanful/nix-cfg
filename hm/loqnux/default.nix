{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway
    ../wezterm
  ];

  home.packages = with pkgs; [
    floorp
    chromium
    libsForQt5.qt5ct
    discord-canary
    obsidian
    zoom-us
    distrobox
    azure-cli
    sops
    obs-studio
    obs-studio-plugins.wlrobs
    spotify-player
    feh
    beekeeper-studio
    sqlite
    godot_4
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

}
