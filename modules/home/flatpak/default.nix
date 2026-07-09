{ flake, ... }:
{

  imports = [ flake.inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.beekeeperstudio.Studio"
    "md.obsidian.Obsidian"
    "us.zoom.Zoom"
  ];
}
