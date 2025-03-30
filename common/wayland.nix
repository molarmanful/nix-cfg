{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
}
