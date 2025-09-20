{ config, ... }:
{
  programs.ssh = {
    enable = true;
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
