{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
_self: super:
let
  inherit (super.stdenv.hostPlatform) system;
in
{
  inherit (inputs.kirsch.packages.${system}) kirsch;
  inherit (inputs.ANAKRON.packages.${system}) ANAKRON;
  inherit (inputs.QUINTESSON.packages.${system}) QUINTESSON;
  inherit (inputs.apple-fonts.packages.${system}) sf-pro ny;
  inherit (inputs.waybar.packages.${system}) waybar;
  inherit (self.packages.${system}) neovim alacritty lsfg-vk;

  # TODO: remove when fixed
  openldap = super.openldap.overrideAttrs {
    doCheck = !super.stdenv.hostPlatform.isi686;
  };
}
