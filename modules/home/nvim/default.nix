{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ neovim ];

    shellAliases = {
      v = "nvim";
      vim = "nvim";
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
