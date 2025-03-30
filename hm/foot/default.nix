{ upkgs, lib, ... }:

{
  programs.foot = {
    enable = true;
    package = upkgs.foot;
    server.enable = true;

    settings = {
      main =
        let
          font = lib.mkForce "kirsch:pixelsize=16, Symbols Nerd Font:pixelsize=12";
        in
        {
          inherit font;
          font-bold = font;
          font-italic = font;
          font-bold-italic = font;
          box-drawings-uses-font-glyphs = "yes";
          font-size-adjustment = "100%";
          pad = "8x8 center";
        };

      mouse = {
        hide-when-typing = "yes";
      };

      text-bindings = {
        "\\x17" = "Control+BackSpace";
      };
    };
  };
}
