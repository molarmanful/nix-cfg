{
  wezterm,
  inputs,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    package = wezterm;
    colorSchemes = {
      abyssal = inputs.abyssal.lib.wezterm;
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
