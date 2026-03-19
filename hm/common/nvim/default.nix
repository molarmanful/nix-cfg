{ inputs, system, ... }:

{
  home = {
    packages = [ inputs.self.packages.${system}.neovim ];

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
