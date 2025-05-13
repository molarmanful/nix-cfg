{
  inputs,
  upkgs,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    package = upkgs.wezterm;
    colorSchemes = {
      abyssal = inputs.abyssal.lib.wezterm;
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
