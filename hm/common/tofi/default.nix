{
  upkgs,
  kirsch,
  scheme,
  ...
}:
{

  stylix.targets.tofi.enable = false;

  home.packages = [
    (upkgs.callPackage ./tofi-pwr.nix { })
  ];

  programs.tofi = {
    enable = true;
    package = upkgs.tofi;
    settings =
      let

        dims = {
          w = 12;
          h = 32;
        };
        off = {
          x = (1920 - dims.w * 20) * 50 / 1920;
          y = n: (1080 - dims.h * n) * 50 / 1080;
        };
        num-results = 10;

      in
      {

        inherit num-results;
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-left = "${builtins.toString off.x}%";
        padding-top = "${builtins.toString (off.y num-results)}%";
        font = "${kirsch}/share/fonts/kirsch.ttf";
        font-size = dims.h * 3 / 4;
        prompt-text = "\"  \"";
        background-color = "#000A";
        text-color = scheme.base05;
        prompt-color = scheme.base0E;
        selection-color = scheme.base0B;
        hint-font = false;
        ascii-input = true;

      };
  };
}
