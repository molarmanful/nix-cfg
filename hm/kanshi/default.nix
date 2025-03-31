{

  services.kanshi = {
    enable = true;
    systemdTarget = "";
    settings = [
      {
        profile = {
          name = "solo";
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "ext-left";
          outputs = [
            {
              criteria = "DP-9";
              position = "0,0";
              mode = "1920x1080@144Hz";
            }
            {
              criteria = "eDP-1";
              position = "1920,0";
            }
          ];
        };
      }
    ];
  };
}
