{ pkgs, ... }:
{

  home.packages = with pkgs; [
    fishPlugins.puffer
    fishPlugins.fzf
    fishPlugins.hydro
  ];

  stylix.targets.fish.enable = false;
  programs.fish = {
    enable = true;

    shellInit = ''
      function _my_postexec --on-event fish_postexec
          set -l last_status $pipestatus
          set -g _my_status_c "$_hydro_color_prompt"
          set -g _my_status_e ""

          for code in $pipestatus
              if test $code -ne 0
                  set -g _my_status_c "$_hydro_color_error"
                  set -g _my_status_e "$_hydro_color_error"(echo $last_status)" | "
                  break
              end
          end
      end

      set -g hydro_symbol_prompt ∫
      set -g hydro_color_prompt cyan
      set -g hydro_color_pwd yellow
      set -g hydro_color_git green
      set -g hydro_color_duration blue

      set -g _color_shlvl (set_color magenta)
      set -g _shlvl ""
      if test $SHLVL -gt 1
          set -g _shlvl "$SHLVL"
      end
    '';

    interactiveShellInit = ''
      tabs 4
    '';

    functions = {

      fish_greeting = "";

      _my_postexec = {
        onEvent = "fish_postexec";
        body = ''
          set -l last_status $pipestatus
          set -g _my_status_c "$_hydro_color_prompt"
          set -g _my_status_e ""
          for code in $pipestatus
              if test $code -ne 0
                  set -g _my_status_c "$_hydro_color_error"
                  set -g _my_status_e "$_hydro_color_error"(echo $last_status)" | "
                  break
              end
          end
        '';
      };

      fish_prompt = ''
        echo -e (tput cup 999 0)"$_hydro_newline$_hydro_color_prompt$_my_status_c$hydro_symbol_prompt "
      '';

      fish_right_prompt = ''
        echo -e "$_my_status_e$_hydro_color_duration$_hydro_cmd_duration$hydro_color_normal$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $_hydro_color_git$$_hydro_git$hydro_color_normal$_color_shlvl$_shlvl$_hydro_color_normal"
      '';

    };
  };

  programs.fzf.enableFishIntegration = false;
}
