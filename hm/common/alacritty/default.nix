{
  inputs,
  upkgs,
  lib,
  ...
}:

{
  stylix.targets.alacritty.enable = false;
  programs.alacritty = {
    enable = true;

    package = upkgs.alacritty.override {
      rustPlatform = upkgs.rustPlatform // {
        buildRustPackage =
          args:
          upkgs.rustPlatform.buildRustPackage (
            args
            // {
              src = builtins.fetchGit {
                url = "https://github.com/ayosec/alacritty";
                ref = "graphics";
                rev = "814e8fefc60b4457ea155d11df9f27795de830ec";
              };
              cargoHash = "sha256-Pr2VTPa/1SNr1W4NkxDKquj10uArR/M3WxVjhI1Ioko=";
            }
          );
      };
    };

    settings = {

      window = {
        padding = {
          x = 16;
          y = 16;
        };
        dynamic_padding = true;
        decorations = "None";
      };

      font = {
        normal = {
          family = "kirsch";
          style = "Regular";
        };
        bold = {
          style = "Regular";
        };
        size = 12;
        builtin_box_drawing = false;
      };

      colors =
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
          primary = { inherit (theme) foreground background; };
          cursor = {
            text = theme.cursor_fg;
            cursor = theme.cursor_bg;
          };
          selection = {
            text = theme.selection_fg;
            background = theme.selection_bg;
          };
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

      mouse = {
        hide_when_typing = true;
      };

      keyboard.bindings = [
        {
          mods = "Control";
          key = "Backspace";
          chars = "\\u0017";
        }
        {
          mods = "Control|Shift";
          key = "N";
          action = "CreateNewWindow";
        }
      ];

    };
  };

  xdg.configFile."fontconfig/conf.d/99-alacritty-fallback.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <match target="pattern">
        <test name="prgname">
          <string>alacritty</string>
        </test>
        <edit name="family" mode="append" binding="weak">
          <string>Symbols Nerd Font</string>
        </edit>
      </match>
      <match target="font">
        <test name="prgname">
          <string>alacritty</string>
        </test>
        <test name="family">
          <string>Symbols Nerd Font</string>
        </test>
        <edit name="matrix" mode="assign">
          <times>
            <name>matrix</name>
            <matrix>
              <double>0.69</double><double>0</double>
              <double>0</double><double>0.69</double>
            </matrix>
          </times>
        </edit>
      </match>
    </fontconfig>
  '';
}
