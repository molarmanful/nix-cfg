_inputs:
{
  wlib,
  pkgs,
  ...
}:

{
  imports = [
    wlib.wrapperModules.claude-code
  ];

  config = {
    settings = {
      permissions = {
        deny = [
          "Read(./.env)"
          "Read(./.env.*)"
          "Read(./secrets/**)"
          "Read(./config/credentials.json)"
          "Read(./build)"
        ];
        disableBypassPermissionsMode = "disable";
      };
      env.ANTHROPIC_BASE_URL = "https://api.anthropic.com";
      spinnerVerbs = {
        mode = "replace";
        verbs = [ "Loading" ];
      };
      hooks.PreToolUse = [
        {
          matcher = "*";
          hooks = [
            {
              type = "command";
              command = /* sh */ ''
                e=$(${pkgs.jq}/bin/jq -r '.oauthAccount.emailAddress // empty' "$HOME/.claude.json" 2>/dev/null)
                [ -n "$e" ] && ${pkgs.gnugrep}/bin/grep -qiF -- "$e" && echo "blocked: input contains the account email" >&2 && exit 2 || exit 0
              '';
            }
          ];
        }
      ];
    };

    constructFiles.defaultSettings = {
      relPath = "claude-default-settings.json";
      content = builtins.toJSON {
        enabledPlugins = {
          "code-simplifier@claude-plugins-official" = true;
          "security-guidance@claude-plugins-official" = true;
          "claude-md-management@claude-plugins-official" = true;
          "claude-code-setup@claude-plugins-official" = true;
          "superpowers@claude-plugins-official" = true;
        };
        feedbackDrafts = "off";
        alwaysThinkingEnabled = true;
        promptSuggestionEnabled = false;
        awaySummaryEnabled = false;
        tui = "fullscreen";
      };
    };
  };
}
