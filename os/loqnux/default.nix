{
  lib,
  pkgs,
  config,
  sf-pro,
  ny,
  kirsch,
  anakron,
  ...
}:
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
  };

  hardware = {
    enableAllFirmware = true;

    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:5:0:0";
        sync.enable = lib.mkDefault true;
      };
    };

    pulseaudio.enable = false;

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

    getty.autologinUser = "ben";
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
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

    user.services.kanshi = {
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
    with pkgs;
    lib.mkForce [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
        ];
      })
      sf-pro
      ny
      fira-code-nerdfont
      fira
      dejavu_fonts
      julia-mono
      proggyfonts
      cozette
      kirsch
      anakron
    ];

  console = {
    earlySetup = true;
    packages = [ anakron ];
    font = "${anakron}/share/consolefonts/ANAKRON.psfu";
  };

  stylix = {
    enable = true;

    image = ../../wp/skull.png;
    imageScalingMode = "fit";
    polarity = "dark";

    base16Scheme = {
      base00 = "#000000";
      base01 = "#212e3f";
      base02 = "#29394f";
      base03 = "#575860";
      base04 = "#71839b";
      base05 = "#cdcecf";
      base06 = "#aeafb0";
      base07 = "#e4e4e5";
      base08 = "#c94f6d";
      base09 = "#f4a261";
      base0A = "#dbc074";
      base0B = "#81b29a";
      base0C = "#63cdcf";
      base0D = "#719cd6";
      base0E = "#9d79d6";
      base0F = "#d67ad2";
    };

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
        package = pkgs.julia-mono;
      };
    };

    cursor = {
      name = "Simp1e-Dark";
      package = pkgs.simp1e-cursors;
      size = 24;
    };

    targets.fish.enable = false;
  };
}
