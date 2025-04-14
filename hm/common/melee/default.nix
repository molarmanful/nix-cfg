{ inputs, config, ... }:
{
  imports = [
    inputs.slippi.homeManagerModules.default
  ];
  slippi-launcher = {
    enable = true;
    isoPath = "${config.home.homeDirectory}/ISO/melee.iso";
    launchMeleeOnPlay = false;
  };
}
