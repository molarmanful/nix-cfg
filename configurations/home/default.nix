{ flake, ... }:
{
  imports = [ flake.inputs.self.homeModules.default ];
  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    stateVersion = "25.11";
  };
}
