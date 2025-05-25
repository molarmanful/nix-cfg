{ pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/nvidia.nix
    ../common/wayland.nix
  ];

  networking.hostName = "loqnux";

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
