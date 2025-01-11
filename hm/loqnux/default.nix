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
    discord
    obsidian
    zoom-us
    godot_4
    distrobox
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
}
