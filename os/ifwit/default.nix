{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/amd.nix
  ];

  networking.hostName = "ifwit";
}
