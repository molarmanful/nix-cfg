{ pkgs, inputs, ... }:
{
  home =
    let
      nvim-base = import ../nvim { inherit inputs; };
      nvim = nvim-base.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in
    {
      packages = [
        nvim
      ];
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
}
