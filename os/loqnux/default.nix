{ pkgs, config, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../.
  ];

  networking = {
    hostName = "loqnux";
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:5:0:0";
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

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "leftmeta";
              leftmeta = "leftalt";
              "leftalt" = "rightcontrol";
              "leftshift+leftmeta" = "rightcontrol";
            };
          };
          extraConfig = '''';
        };
      };
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
          user = "greeter";
        };
      };
    };

    printing.enable = true;
  };

  powerManagement.powertop.enable = true;

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    etc."libinput/local-overrides.quirks".text = ''
      [Serial Keyboards]
      MatchUdevType=keyboard
      MatchName=keyd virtual keyboard
      AttrKeyboardIntegration=internal
    '';
  };

  time.timeZone = "America/NewYork";

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
