{
  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    allowManagedPermissionRulesOnly = true;
    allowManagedHooksOnly = true;
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
  };
}
