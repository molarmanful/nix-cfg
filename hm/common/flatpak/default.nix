{ inputs, ... }:
{

  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "dev.vencord.Vesktop"
    "io.beekeeperstudio.Studio"
    "md.obsidian.Obsidian"
    "us.zoom.Zoom"
    "com.slack.Slack"
  ];
}
