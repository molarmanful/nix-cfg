{ pkgs, config, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../.
  ];

  networking = {
    hostName = "loqnux";
    wireless.enable = true;
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.canTouchEfiVariables = true;

  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        # FIXME
        # nvidiaBusId = "PCI:14:0:0";
        # amdgpuBusId = "PCI:54:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    pulseaudio.enable = false;
  };

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    power-profiles-daemon.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;
  };

  powerManagement.powertop.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.timeZone = "America/New York";

  i18n.defaultLocale = "en_US.UTF-8";

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY = "wayland-1";
      DISPLAY = ":0";
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

}
