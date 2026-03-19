{ stateVersion, ... }:
{
  imports = [ ./common ];
  system = { inherit stateVersion; };
}
