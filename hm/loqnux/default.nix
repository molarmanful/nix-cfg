{ pkgs, mypkgs, ... }:

{
  imports = [
    ../.
    ../../common/wayland.nix
    ../xresources
    ../kanshi
    ../river
    ../wezterm
    ../foot
    ../godot
    ../melee
    ../floorp
  ];

  home.packages = with pkgs; [
    chromium
    libsForQt5.qt5ct
    vesktop
    obsidian
    # zoom-us
    distrobox
    azure-cli
    sops
    obs-studio
    obs-studio-plugins.wlrobs
    spotify-player
    feh
    mypkgs.beekeeper
    sqlite
    bluetuith
    pavucontrol
    pw-volume
    helvum
    wl-clipboard-rs
    wl-clip-persist
    playerctl
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
}
