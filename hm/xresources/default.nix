{ inputs, lib, ... }:

let
  colors = inputs.abyssal.lib.wezterm;
in

{
  xresources.properties =
    {
      "foreground" = colors.foreground;
      "background" = colors.background;
    }
    // lib.listToAttrs (
      lib.lists.imap0 (i: v: {
        name = "color${toString i}";
        value = v;
      }) (colors.ansi ++ colors.brights)
    );
}
