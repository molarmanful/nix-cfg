{
  upkgs,
  lib,
  inputs,
  ...
}:

{
  stylix.targets.foot.enable = false;

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

      colors =
        let
          colors = inputs.abyssal.lib.wezterm;
        in
        {
          background = builtins.substring 1 (-1) colors.background;
          foreground = builtins.substring 1 (-1) colors.foreground;
        }
        // (builtins.listToAttrs (
          lib.lists.imap0 (i: v: {
            name = "regular${builtins.toString i}";
            value = builtins.substring 1 (-1) v;
          }) colors.ansi
        ))
        // (builtins.listToAttrs (
          lib.lists.imap0 (i: v: {
            name = "bright${builtins.toString i}";
            value = builtins.substring 1 (-1) v;
          }) colors.brights
        ));

      text-bindings = {
        "\\x17" = "Control+BackSpace";
      };
    };
  };
}
