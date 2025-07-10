{
  services.easyeffects = {
    enable = true;
    extraPresets = {
      perfect-eq = builtins.fromJSON (builtins.readFromFile ./perfect-eq.json);
    };
    preset = "perfect-eq";
  };
}
