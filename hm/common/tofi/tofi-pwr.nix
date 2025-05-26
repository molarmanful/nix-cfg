{
  widthN,
  heightN,
  writeShellApplication,
  tofi,
  ...
}:

writeShellApplication {
  name = "tofi-pwr";
  runtimeInputs = [ tofi ];

  text = ''
    case $(
      printf '%s\n' suspend hibernate hybrid shutdown reboot |
      tofi --prompt-text=' ⏻ ' --width=${toString (widthN 20)} --height=${toString (heightN 5)} --output="$(
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
