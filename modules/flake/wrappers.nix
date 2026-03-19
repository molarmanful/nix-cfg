{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  flake.wrappers = {
    neovim = import ../neovim inputs;
  };
}
