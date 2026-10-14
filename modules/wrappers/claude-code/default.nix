_inputs:
{
  wlib,
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
