{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {

      "*" = {
        addKeysToAgent = "yes";
        hashKnownHosts = true;
      };

      "github.com" = {
        hostname = "github.com";
        identityFile = config.sops.secrets."private_keys/molarmanful".path;
        identitiesOnly = true;
      };

    };
  };
}
