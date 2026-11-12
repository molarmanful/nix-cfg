{
  flake,
  config,
  ...
}:
let
  inherit (flake) inputs;
in

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${inputs.secrets}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private_keys/molarmanful" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      "private_keys/updoc" = {
        path = "${config.home.homeDirectory}/.ssh/updoc_ed25519";
      };
    };
  };
}
