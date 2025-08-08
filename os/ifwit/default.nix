{
  inputs,
  lib,
  pkgs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/amd.nix
    ../common/wayland.nix
  ];

  networking = {
    hostName = "ifwit";
    networkmanager.ensureProfiles.profiles = inputs.secrets.nm_profiles.ifwit;
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [ fw-ectool ];
    sessionVariables = {
      WLR_RENDERER = "vulkan";
    };
  };

  services.keyd.enable = lib.mkForce false;
}
