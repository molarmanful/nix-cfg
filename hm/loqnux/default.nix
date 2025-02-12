{ pkgs, ... }:

let
  pinnedZoomPkgs =
    import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb.tar.gz";
        sha256 = "0ngw2shvl24swam5pzhcs9hvbwrgzsbcdlhpvzqc7nfk8lc28sp3";
      })
      {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
in

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
    pinnedZoomPkgs.zoom-us
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
    bluetuith
    pavucontrol
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
}
