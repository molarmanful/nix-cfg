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
  ...
}:
{

  imports = [ ../. ];

  sops.secrets = {
    "nm.env" = { };
  };

  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [ config.sops.secrets."nm.env".path ];
      profiles = inputs.secrets.nm_profiles.default;
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
    kernelParams = [ "usbcore.autosuspend=-1" ];
  };

  hardware = {
    enableAllFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;
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

    yeetmouse = {
      enable = true;
      sensitivity = 0.5;
      outputCap = 2.0;
      mode.natural = {
        acceleration = 0.25;
        midpoint = 10.0;
        exponent = 2.5;
        useSmoothing = true;
      };
    };
  };

  services = {
    power-profiles-daemon.enable = false;
    tlp.enable = false;
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "never";
        };
      };
    };

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
            rightcontrol = "rightcontrol";
            rightshift = "layer(apl)";
          };
          apl = {
            "`" = "⋄";
            "1" = "¨";
            "2" = "¯";
            "3" = "<";
            "4" = "≤";
            "5" = "=";
            "6" = "≥";
            "7" = ">";
            "8" = "≠";
            "9" = "∨";
            "0" = "∧";
            "-" = "×";
            "=" = "÷";
            "q" = "?";
            "w" = "⍵";
            "e" = "∊";
            "r" = "⍴";
            "t" = "~";
            "y" = "↑";
            "u" = "↓";
            "i" = "⍳";
            "o" = "○";
            "p" = "⋆";
            "[" = "←";
            "]" = "→";
            "\\" = "⊢";
            "a" = "⍺";
            "s" = "⌈";
            "d" = "⌊";
            "f" = "_";
            "g" = "∇";
            "h" = "∆";
            "j" = "∘";
            "k" = "'";
            "l" = "⎕";
            ";" = "⍎";
            "'" = "⍕";
            "z" = "⊂";
            "x" = "⊃";
            "c" = "∩";
            "v" = "∪";
            "b" = "⊥";
            "n" = "⊤";
            "m" = "|";
            "," = "⍝";
            "." = "⍀";
            "/" = "⌿";
          };
          "shift+apl" = {
            "`" = "⌺";
            "1" = "⌶";
            "2" = "⍫";
            "3" = "⍒";
            "4" = "⍋";
            "5" = "⌽";
            "6" = "⍉";
            "7" = "⊖";
            "8" = "⍟";
            "9" = "⍱";
            "0" = "⍲";
            "-" = "!";
            "=" = "⌹";
            "e" = "⍷";
            "t" = "⍨";
            "i" = "⍸";
            "o" = "⍥";
            "p" = "⍣";
            "[" = "⍞";
            "]" = "⍬";
            "\\" = "⊣";
            "f" = "⍛";
            "j" = "⍤";
            "k" = "⌸";
            "l" = "⌷";
            ";" = "≡";
            "'" = "≢";
            "z" = "⊆";
            "x" = "⊇";
            "," = "⍪";
            "." = "⍙";
            "/" = "⍠";
          };
        };
      };
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --cmd 'river |& tee river.log' --asterisks --remember --remember-user-session --time";
          user = "greeter";
        };
        initial_session = {
          command = "river |& tee river.log";
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

    fstrim.enable = true;

    flatpak.enable = true;

    ratbagd = {
      enable = true;
      package = mypkgs.libratbag;
    };
  };

  powerManagement.powertop.enable = true;

  environment = {
    systemPackages = with upkgs; [
      piper
      mypkgs.keyb0xx
      (lutris.override {
        extraPkgs =
          pkgs: with pkgs; [
            wineWowPackages.stagingFull
            winetricks
          ];
      })
      steamtinkerlaunch
      libstrangle
      mangohud
      protontricks
      mypkgs.nexusmods-app
    ];

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

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  specialisation = {
    unplugged.configuration = {
      system.nixos.tags = [ "unplugged" ];
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

    base16Scheme = inputs.abyssal.lib.stylix;

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
