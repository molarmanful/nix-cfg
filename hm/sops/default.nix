{ inputs, secretspath, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/ben/.config/sops/age/keys.txt";

    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private_keys/github_sign" = {
        path = "/home/ben/.ssh/id_ed25519";
      };
      "private_keys/updoc" = {
        path = "/home/ben/.ssh/updoc_ed25519";
      };
    };
  };
}
