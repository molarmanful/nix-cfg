inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    wlib.wrapperModules.neovim
  ];

  options = {
    nvim-lib = {
      plugins = lib.mkOption {
        readOnly = true;
        type = lib.types.raw;
        default = f: f (pkgs.vimPlugins // (config.nvim-lib.pluginsFromPrefix "nvim-plugins-" inputs));
      };

      pluginsFromPrefix = lib.mkOption {
        readOnly = true;
        type = lib.types.raw;
        default =
          prefix: inputs:
          lib.pipe inputs [
            builtins.attrNames
            (builtins.filter (s: lib.hasPrefix prefix s))
            (map (
              input:
              let
                name = lib.removePrefix prefix input;
              in
              {
                inherit name;
                value = config.nvim-lib.mkPlugin name inputs.${input};
              }
            ))
            builtins.listToAttrs
          ];
      };
    };
  };

  config = {
    specMods = _: {
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
      };
    };

    extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];

    settings.config_directory = pkgs.stdenvNoCC.mkDerivation {
      pname = "nix-cfg-neovim";
      version = "0.0.0";
      src = ../.;
      nativeBuildInputs = with pkgs; [ neovim ];
      buildPhase = config.nvim-lib.plugins (
        {
          plenary-nvim,
          nfnl,
          nvchad-ui,
          base46,
          ...
        }:
        /* bash */ ''
          export HOME=$(mktemp -d)
          nvim --headless -c 'set rtp+=${nfnl},.' -l - <<EOF
            vim.cmd.edit('.nfnl.fnl')
            vim.cmd.trust()
            require('nfnl.api')['compile-all-files']()
          EOF
          nvim --headless -c 'set rtp+=${plenary-nvim},${nvchad-ui},${base46},.' -l - <<EOF
            vim.g.base46_cache = vim.fn.getcwd() .. '/base46-cache/'
            require('base46').load_all_highlights()
          EOF
        ''
      );
      installPhase = ''
        cp -r . $out
      '';
    };
  };
}
