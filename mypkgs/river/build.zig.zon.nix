{ linkFarm, fetchzip }:

linkFarm "zig-packages" [
  {
    name = "pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX";
    path = fetchzip {
      url = "https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz";
      hash = "sha256-8tA4auo5FEI4IPnomV6bkpQHUe302tQtorFQZ1l14NU=";
    };
  }
  {
    name = "wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl";
    path = fetchzip {
      url = "https://codeberg.org/ifreund/zig-wayland/archive/v0.3.0.tar.gz";
      hash = "sha256-ydEavD9z20wRwn9ZVX56ZI2T5i1tnm3LupVxfa30o84=";
    };
  }
  {
    name = "wlroots-0.19.0-dev-jmOlcpvdAwAeiUvtf6Ah4aHdot8cCWSRS_5BLJj0Ctbu";
    path = fetchzip {
      url = "https://codeberg.org/ifreund/zig-wlroots/archive/75b4dd07c770db1b0c2e7b794381b3ea0d62277b.tar.gz";
      hash = "sha256-R+TxZDvl3TMiwle4JWBEO2vg5yzEbaZPfZvV9wbbBI0=";
    };
  }
  {
    name = "xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr";
    path = fetchzip {
      url = "https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.3.0.tar.gz";
      hash = "sha256-e5bPEfxl4SQf0cqccLt/py1KOW1+Q1+kWZUEXBbh9oQ=";
    };
  }
]
