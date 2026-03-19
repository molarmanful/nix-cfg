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

    nvchad.base46 = lib.mkOption {
      readOnly = true;
      type = lib.types.package;
      default = config.nvim-lib.plugins (
        {
          plenary-nvim,
          nvchad-ui,
          base46,
          ...
        }:
        base46.overrideAttrs {
          buildPhase = ''
            cp ${config.settings.config_directory}/lua/chadrc.lua lua || true
            cp -r ${config.settings.config_directory}/lua/themes lua || true
            ${pkgs.neovim}/bin/nvim --cmd 'set rtp+=${plenary-nvim},${nvchad-ui},.' -l - <<EOF
              vim.g.base46_cache = vim.fn.getcwd() .. '/cache/'
              require('base46').load_all_highlights()
            EOF
          '';
        }
      );
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
  };
}
