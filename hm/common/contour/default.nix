{
  inputs,
  lib,
  upkgs,
  ...
}:

{
  home.packages = with upkgs; [
    contour
  ];

  xdg.configFile."contour/contour.yml".text = builtins.toJSON {
    profiles.main = {
      show_title_bar = false;
      scrollbar.position = "Hidden";
      status_line.display = "none";
      margins = {
        horizontal = 8;
        vertical = 8;
      };
      history = {
        limit = 3500;
        scroll_multiplier = 1;
      };
      font = {
        size = 16;
        builtin_box_drawing = false;
        regular.family = "kirsch";
      };
    };

    color_schemes.default =
      let
        theme = inputs.abyssal.lib.wezterm;
        ansi = [
          "black"
          "red"
          "green"
          "yellow"
          "blue"
          "magenta"
          "cyan"
          "white"
        ];
      in
      {
        default = { inherit (theme) background foreground; };
        normal = builtins.listToAttrs (
          lib.zipListsWith (a: b: {
            name = a;
            value = b;
          }) ansi theme.ansi
        );
        bright = builtins.listToAttrs (
          lib.zipListsWith (a: b: {
            name = a;
            value = b;
          }) ansi theme.brights
        );
      };
  };
}
