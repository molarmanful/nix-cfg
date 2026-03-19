{
  services.easyeffects = {
    enable = true;
    extraPresets = {
      perfect-eq = builtins.fromJSON (builtins.readFile ./perfect-eq.json);
      advanced-auto-gain = builtins.fromJSON (builtins.readFile ./advanced-auto-gain.json);
    };
    preset = "perfect-eq";
  };
}
