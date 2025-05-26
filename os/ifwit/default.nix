{ inputs, ... }:
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

  environment.sessionVariables = {
    WLR_RENDERER = "vulkan";
  };
}
