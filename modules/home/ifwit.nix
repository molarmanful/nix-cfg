{ flake, ... }:
{
  imports = [ flake.inputs.self.homeModules.nixos ];
  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    stateVersion = "25.11";
  };
  wayland.windowManager.river.touchpadScrollFactor = 0.1;
}
