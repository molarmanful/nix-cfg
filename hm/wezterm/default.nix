{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [ wezterm ];

  programs.wezterm = {
    enable = true;
    colorSchemes = {
      abyssal = inputs.abyssal.lib.wezterm;
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
