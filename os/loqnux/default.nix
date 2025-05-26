{ inputs, pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/nvidia.nix
    ../common/wayland.nix
  ];

  networking = {
    hostName = "loqnux";
    networkmanager.ensureProfiles.profiles = inputs.secrets.nm_profiles.loqnux;
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-partlabel/NixOS";
      preLVM = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [ lenovo-legion ];

    sessionVariables = {
      # WLR_RENDERER = "vulkan";
    };
  };
}
