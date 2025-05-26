{ writeShellApplication, tofi, ... }:

writeShellApplication {
  name = "tofi-pwr";
  runtimeInputs = [ tofi ];

  text = ''
    case $(
      printf '%s\n' suspend hibernate hybrid shutdown reboot |
      tofi --prompt-text=' ⏻ ' --output="$(
        river-bedload -print outputs | jq -r '.[] | first(select(.focused)).name'
      )"
    ) in
      suspend) systemctl suspend ;;
      hibernate) systemctl hibernate ;;
      hybrid) systemctl hibernate-then-suspend ;;
      shutdown) shutdown now ;;
      reboot) reboot ;;
    esac
  '';
}
