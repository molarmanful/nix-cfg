{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./hardware-configuration.nix
    self.nixosModules.gui
    self.nixosModules.amd
    self.nixosModules.wayland
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

  home-manager.users.ben = {
    imports = [ self.homeModules.ifwit ];
  };

  system.stateVersion = "25.11";
}
