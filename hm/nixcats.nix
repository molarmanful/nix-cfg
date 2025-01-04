{pkgs, inputs, ...}: {
  # programs.neovim.enable = true;
  home =
    let
      nvim = inputs.nvim-cfg.packages."${pkgs.system}".default;
    in {
      packages = [
        nvim
      ];
      sessionVariables = {
        EDITOR = "${nvim}";
        VISUAL = "${nvim}";
      };
    };
}
