{ upkgs, ... }:
{
  programs.urxvt = {
    enable = true;
    package = upkgs.rxvt-unicode-emoji;
    scroll.bar.enable = false;
    fonts = [
      "xft:kirsch Propo:style=Regular:autohint=false:antialias=false,minspace=false"
      "xft:Symbols Nerd Font Mono:size=9:autohint=true:antialias=true,minspace=false"
    ];
    extraConfig = {
      boldFont = "";
      italicFont = "";
      boldItalicFont = "";
      "keysym.Control-Shift-c" = "eval:selection_to_clipboard";
      "keysym.Control-Shift-v" = "eval:paste_clipboard";
      "keysym.Control-Meta-c" = "builtin-string:";
      "keysym.Control-Meta-v" = "builtin-string:";
      internalBorder = 8;
      iso14755 = false;
      urlLauncher = "floorp";
      underlineURLs = true;
      urlButton = 1;
    };
  };
}
