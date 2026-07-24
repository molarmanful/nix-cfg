inputs:
{
  wlib,
  ...
}:

{
  imports = [
    wlib.wrapperModules.fuzzel
  ];

  config = {
    settings = {
      main = {
        font = "kirsch2x:pixelsize=32";
        prompt = "\" \"";
        lines = 10;
        minimal-lines = true;
        horizontal-pad = 24;
        vertical-pad = 24;
        inner-pad = 12;
        image-size-ratio = 1;
        icons-enabled = false;
      };

      colors =
        let
          scheme = builtins.mapAttrs (_: v: "${v}ff") inputs.abyssal.lib.stylix;
        in
        {
          background = scheme.base00;
          text = scheme.base04;
          message = scheme.base05;
          prompt = scheme.base0E;
          placeholder = scheme.base04;
          input = scheme.base05;
          match = scheme.base0C;
          selection = scheme.base00;
          selection-text = scheme.base0B;
          selection-match = scheme.base0C;
          counter = scheme.base08;
          border = scheme.base03;
        };

      border.radius = 0;

      key-bindings = {
        prev = "Up Control+k";
        next = "Down Control+j";
        delete-line-forward = "none";
      };
    };
  };
}
