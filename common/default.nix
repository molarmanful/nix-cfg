{ inputs, ... }:
{
  nixpkgs = {
    overlays = [ inputs.nixpkgs-wayland.overlay ];
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };
}
