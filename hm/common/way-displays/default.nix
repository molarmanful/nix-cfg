{ upkgs, ... }:
{

  home.packages = with upkgs; [ way-displays ];

  services.way-displays = {
    enable = true;
    systemdTarget = "";
    settings = {

      ORDER = [
        "ARZOPA"
        "!^eDP-"
        "!^DP-"
        "!.*$"
      ];

      AUTO_SCALE = false;

      MODE = [
        {
          NAME_DESC = "!.*$";
          MAX = true;
        }
      ];

      VRR_OFF = [ "ARZOPA" ];

      CALLBACK_CMD = "";

    };
  };
}
