{ inputs, ... }:
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  systems = [ "x86_64-linux" ];

  perSystem =
    { self', ... }:
    {
      packages = {
        default = self'.packages.activate;
      };
    };
}
