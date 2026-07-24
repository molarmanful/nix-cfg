{
  pkgs,
  ...
}:

let
  fuzzel-pwr = pkgs.writeShellApplication {
    name = "fuzzel-pwr";
    runtimeInputs = with pkgs; [ fuzzel ];
    text = ''
      case $(
        printf '%s\n' suspend hibernate hybrid shutdown reboot |
        fuzzel --dmenu --prompt-text=' ⏻ ' --width=20
      ) in
        suspend) systemctl suspend ;;
        hibernate) systemctl hibernate ;;
        hybrid) systemctl hibernate-then-suspend ;;
        shutdown) shutdown now ;;
        reboot) reboot ;;
      esac
    '';
  };
in

{
  stylix.targets.fuzzel.enable = false;
  home.packages = with pkgs; [
    fuzzel
    fuzzel-pwr
  ];
}
