{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/amd.nix
  ];

  networking.hostName = "ifwit";

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
