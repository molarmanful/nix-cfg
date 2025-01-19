{ pkgs, ... }:
{
  imports = [
    ../.
    ../sway
    ../wezterm
  ];

  home = {
    packages = with pkgs; [
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
      godot_4
    ];

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.simp1e-cursors;
      name = "Simp1e-Dark";
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Simp1e-Dark";
      };
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

}
