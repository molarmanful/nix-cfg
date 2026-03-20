{ inputs, lib, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers = lib.pipe ../wrappers [
    builtins.readDir
    builtins.attrNames
    (builtins.map (name: {
      inherit name;
      value = import ../wrappers/${name} inputs;
    }))
    builtins.listToAttrs
  ];
}
