{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in

{
  stylix = {
    enable = true;

    image = ./skull.png;
    imageScalingMode = "fit";
    polarity = "dark";

    base16Scheme = inputs.abyssal.lib.stylix;

    fonts = {
      sansSerif = {
        name = "SF Pro Display";
        package = pkgs.sf-pro;
      };
      serif = {
        name = "New York Small";
        package = pkgs.ny;
      };
      monospace = {
        name = "Julia Mono";
        package = pkgs.julia-mono;
      };
    };

    cursor = {
      name = "Simp1e-Dark";
      package = pkgs.simp1e-cursors;
      size = 24;
    };

    targets.fish.enable = false;
  };
}
