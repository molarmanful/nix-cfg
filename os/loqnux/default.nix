{
  inputs,
  config,
  lib,
  pkgs,
  upkgs,
  mypkgs,
  sf-pro,
  ny,
  kirsch,
  ANAKRON,
  QUINTESSON,
  scheme,
  ...
}:
{

  imports = [
    ../.
    ./hardware-configuration.nix
  ];

  sops.secrets = {
    "nm.env" = { };
  };

  networking = {
    hostName = "loqnux";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [ config.sops.secrets."nm.env".path ];
        profiles = inputs.secrets.nm_profiles;
      };
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;

    pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-partlabel/NixOS";
        preLVM = true;
      };
    };
    kernelParams = [ "usbcore.autosuspend=-1" ];
  };

  hardware = {
    enableAllFirmware = true;

    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:5:0:0";
        sync.enable = lib.mkDefault true;
      };
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    power-profiles-daemon.enable = true;

    pulseaudio.enable = false;

    blueman.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };

    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "leftmeta";
            leftmeta = "leftalt";
            "leftalt" = "rightcontrol";
            "f23+leftshift+leftmeta" = "leftmouse";
          };
        };
      };
    };

    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'river |& tee log.txt'";
          user = "ben";
        };
      };
    };

    printing.enable = true;

    automatic-timezoned.enable = true;
    avahi.enable = true;
    geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

    tailscale.enable = true;

    gvfs.enable = true;
    tumbler.enable = true;

    thermald.enable = true;

    fstrim.enable = true;

    flatpak.enable = true;
  };

  powerManagement.powertop.enable = true;

  environment = {
    systemPackages = with pkgs; [
      lenovo-legion
      vulkan-validation-layers
      mypkgs.keyb0xx
    ];

    sessionVariables = {
      # WLR_RENDERER = "vulkan";
      GBM_BACKEND = "nvidia-drm";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    etc."libinput/local-overrides.quirks".text = ''
      [Serial Keyboards]
      MatchUdevType=keyboard
      MatchName=keyd virtual keyboard
      AttrKeyboardIntegration=internal
    '';
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.hardwareClockInLocalTime = true;

  systemd = {
    services = {
      tune-usb-autosuspend = {
        description = "Disable USB autosuspend";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
        unitConfig.RequiresMountsFor = "/sys";
        script = ''
          echo -1 > /sys/module/usbcore/parameters/autosuspend
        '';
      };
      greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    };

    user.extraConfig = ''
      DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "wlr";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  programs = {
    light.enable = true;

    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "ben" ];
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
    file-roller.enable = true;
  };

  specialisation = {
    unplugged.configuration = {
      system.nixos.tags = [ "unplugged" ];
      hardware.nvidia = {
        prime = {
          offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
          };
          sync.enable = lib.mkForce false;
        };
      };
    };
  };

  fonts.packages =
    with upkgs;
    lib.mkForce [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      sf-pro
      ny
      fira
      dejavu_fonts
      julia-mono
      proggyfonts
      cozette
      kirsch
      QUINTESSON
    ];

  console = {
    earlySetup = true;
    packages = [ ANAKRON ];
    font = "${ANAKRON}/share/consolefonts/ANAKRON.psfu";
  };

  stylix = {
    enable = true;

    image = ../../wp/skull.png;
    imageScalingMode = "fit";
    polarity = "dark";

    base16Scheme = scheme;

    fonts = {
      sansSerif = {
        name = "SF Pro Display";
        package = sf-pro;
      };
      serif = {
        name = "New York Small";
        package = ny;
      };
      monospace = {
        name = "Julia Mono";
        package = upkgs.julia-mono;
      };
    };

    cursor = {
      name = "Simp1e-Dark";
      package = upkgs.simp1e-cursors;
      size = 24;
    };

    targets.fish.enable = false;
  };
}
