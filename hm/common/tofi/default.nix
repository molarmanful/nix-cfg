{
  upkgs,
  kirsch,
  scheme,
  ...
}:
let

  dims = {
    w = 12;
    h = 32;
  };
  num-results = 10;
  padding = dims.w;

  padding-top = padding;
  padding-bottom = padding + dims.w * 2;
  padding-left = padding;
  padding-right = padding;

  widthN = n: n * dims.w + padding-left + padding-right;
  heightN = n: (n + 1) * dims.h + padding-top + padding-bottom;

in
{

  stylix.targets.tofi.enable = false;

  home.packages = [
    (upkgs.callPackage ./tofi-pwr.nix { inherit widthN heightN; })
  ];

  programs.tofi = {
    enable = true;
    package = upkgs.tofi;
    settings = {

      inherit
        num-results
        padding-top
        padding-bottom
        padding-left
        padding-right
        ;
      width = widthN 40;
      height = heightN num-results;
      border-width = 1;
      outline-width = 0;
      font = "${kirsch}/share/fonts/kirsch.ttf";
      font-size = dims.h * 3 / 4;
      prompt-text = "\"  \"";
      background-color = scheme.base00;
      border-color = scheme.base03;
      text-color = scheme.base05;
      prompt-color = scheme.base0E;
      selection-color = scheme.base0B;
      hint-font = false;
      ascii-input = true;

    };
  };
}
