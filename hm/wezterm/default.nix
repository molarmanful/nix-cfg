{ pkgs, ... }:
{
  home.packages = with pkgs; [ wezterm ];

  programs.wezterm = {
    enable = true;
    colorSchemes = {
      abyssal = (builtins.fromTOML (builtins.readFile ./abyssal.toml)).colors;
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
