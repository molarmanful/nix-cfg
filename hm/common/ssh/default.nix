{ config, ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    hashKnownHosts = true;
    matchBlocks = {

      "github.com" = {
        hostname = "github.com";
        identityFile = config.sops.secrets."private_keys/molarmanful".path;
        identitiesOnly = true;
      };

    };
  };
}
